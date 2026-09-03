local utils = require("utils")

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_buf_conf", { clear = true }),
  callback = function(event_context)
    local client = vim.lsp.get_client_by_id(event_context.data.client_id)
    if not client then
      return
    end

    local bufnr = event_context.buf

    -- Mappings.
    local map = function(mode, l, r, opts)
      opts = opts or {}
      opts.silent = true
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    map("n", "gd", function()
      vim.lsp.buf.definition {
        on_list = function(options)
          local unique_defs = {}
          local def_loc_hash = {}

          for _, def_location in pairs(options.items) do
            local hash_key = def_location.filename .. def_location.lnum
            if not def_loc_hash[hash_key] then
              def_loc_hash[hash_key] = true
              table.insert(unique_defs, def_location)
            end
          end

          options.items = unique_defs
          vim.fn.setloclist(0, {}, " ", options)

          if #options.items > 1 then
            vim.cmd.lopen()
          else
            vim.cmd([[silent! lfirst]])
          end
        end,
      }
    end, { desc = "go to definition" })

    map("n", "<C-]>", vim.lsp.buf.definition)
    map("n", "K", vim.lsp.buf.hover)
    map("n", "<C-k>", vim.lsp.buf.signature_help)
    map("n", "<space>rn", vim.lsp.buf.rename, { desc = "variable rename" })
    map("n", "<space>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
    map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, { desc = "add workspace folder" })
    map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, { desc = "remove workspace folder" })
    map("n", "<space>wl", function()
      vim.print(vim.lsp.buf.list_workspace_folders())
    end, { desc = "list workspace folder" })

    -- Disable Ruff hover in favor of Pyright
    if client.name == "ruff" then
      client.server_capabilities.hoverProvider = false
    end

    -- Enable inlay hints dynamically if supported
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end

    -- Highlight current variable and its usages
    if client.server_capabilities.documentHighlightProvider then
      local gid = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
      vim.api.nvim_create_autocmd("CursorHold", {
        group = gid,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.document_highlight()
        end,
      })

      vim.api.nvim_create_autocmd("CursorMoved", {
        group = gid,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.clear_references()
        end,
      })
    end
  end,
  nested = true,
  desc = "Configure buffer keymap and behavior based on LSP",
})

-- Global hover handler with border and size
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = "single", max_height = 25, max_width = 120 }
)

-- Enable lsp servers when they are available
local capabilities = require("lsp_utils").get_default_capabilities()

vim.lsp.config("*", {
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 200, -- snappier than 500
  },
})

-- A mapping from lsp server name to the executable name
local enabled_lsp_servers = {
  pyright = "pyright-langserver",
  ruff = "ruff",
  lua_ls = "lua-language-server",
  vimls = "vim-language-server",
  bashls = "bash-language-server",
  yamlls = "yaml-language-server",
  rust_analyzer = "rust-analyzer",
}

for server_name, lsp_executable in pairs(enabled_lsp_servers) do
  if utils.executable(lsp_executable) then
    vim.lsp.enable(server_name)
  else
    local msg = string.format(
      "Executable '%s' for server '%s' not found! Server will not be enabled",
      lsp_executable,
      server_name
    )
    vim.notify(msg, vim.log.levels.WARN, { title = "Nvim-config" })
  end
end
