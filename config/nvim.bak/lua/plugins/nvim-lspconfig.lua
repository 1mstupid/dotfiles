return {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
        local lspconfig = require("lspconfig")
        -- keymaps (must define opts)
        local opts = { noremap = true, silent = true }
        vim.keymap.set("n", "ca", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    end,
}
