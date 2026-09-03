return {
    {
        "gbprod/yanky.nvim",
        config = function()
            require("config.yanky")
        end,
        cmd = "YankyRingHistory",
    },
    "andweeb/presence.nvim",
    {
        "kr40/nvim-macros",
        cmd = { "MacroSave", "MacroYank", "MacroSelect", "MacroDelete" },
        opts = {
            json_file_path = vim.fs.normalize(vim.fn.stdpath("config") .. "/macros.json"),
            default_macro_register = "q",
            json_formatter = "none",
        },
    },
    -- {
    --     "swaits/zellij-nav.nvim",
    --     lazy = true,
    --     event = "VeryLazy",
    --     keys = {
    --         { "<c-h>", "<cmd>ZellijNavigateLeftTab<cr>",  { silent = true, desc = "navigate left or tab" } },
    --         { "<c-j>", "<cmd>ZellijNavigateDown<cr>",     { silent = true, desc = "navigate down" } },
    --         { "<c-k>", "<cmd>ZellijNavigateUp<cr>",       { silent = true, desc = "navigate up" } },
    --         { "<c-l>", "<cmd>ZellijNavigateRightTab<cr>", { silent = true, desc = "navigate right or tab" } },
    --     },
    --     opts = {},
    -- },
    {
        "ray-x/lsp_signature.nvim",
        event = "BufRead",
        config = function()
            require("lsp_signature").setup()
        end,
    },

    {
        "m4xshen/hardtime.nvim",
        lazy = true,
        dependencies = { "MunifTanjim/nui.nvim" },
        opts = {},
    },
    { "machakann/vim-sandwich", event = "VeryLazy" },

    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            -- more beautiful vim.ui.input
            input = {
                enabled = true,
                win = {
                    relative = "cursor",
                    backdrop = true,
                },
            },
            -- more beautiful vim.ui.select
            picker = { enabled = true },
        },
    },

    {
        "smoka7/hop.nvim",
        keys = { "f" },
        config = function()
            require("config.nvim_hop")
        end,
    },

    {
        "akinsho/toggleterm.nvim",
        cmd = { "ToggleTerm", "TermExec" },
        opts = {
            highlights = {
                Normal = { link = "Normal" },
                NormalNC = { link = "NormalNC" },
                NormalFloat = { link = "NormalFloat" },
                FloatBorder = { link = "NormalBorder" },
                StatusLine = { link = "StatusLine" },
                StatusLineNC = { link = "StatusLineNC" },
                WinBar = { link = "WinBar" },
                WinBarNC = { link = "WinBarNC" },
            },
            size = 10,
            on_create = function()
                vim.opt.foldcolumn = "0"
                vim.opt.signcolumn = "no"
            end,
            open_mapping = [[<F7>]],
            shading_factor = 2,
            direction = "float",
            float_opts = { border = "rounded" },
        },
    },
    -- show and trim trailing whitespaces
    { "jdhao/whitespace.nvim",  event = "VeryLazy" },
    {
        {
            "nvim-zh/better-escape.vim",
            event = { "InsertEnter" },
            config = function()
                -- extra mappings for terminal buffers
                vim.g.better_escape_use_xkbswitch = 0
                vim.api.nvim_create_autocmd("TermOpen", {
                    pattern = "term://*",
                    callback = function()
                        vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], { noremap = true, silent = true })
                        vim.api.nvim_buf_set_keymap(0, "t", "nn", [[<C-\><C-n>]], { noremap = true, silent = true })
                    end,
                })
            end,
        },
    },

    { "simnalamburt/vim-mundo", cmd = { "MundoToggle", "MundoShow" } },

    -- Color highlighter
    {
        "norcalli/nvim-colorizer.lua",
    },

    -- focus mode (hide everything except the the file)
    -- {
    -- 	"folke/zen-mode.nvim",
    -- 	cmd = "ZenMode",
    -- 	opts = {
    -- 		plugins = {
    -- 			options = {
    -- 				laststatus = 0,
    -- 			},
    -- 			tmux = true,
    -- 			wezterm = { enabled = true, font = "18" },
    -- 		},
    -- 	},
    -- 	keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
    -- },

    -- code snippets images
    -- {
    --     "mistricky/codesnap.nvim",
    --     build = "make",
    --     config = function()
    --         require("codesnap").setup({
    --             watermark = "",
    --             save_path = "~/Pictures/CodeSnaps", -- Set a save directory
    --         })
    --     end,
    -- },

    -- indent line
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent = {
                char = "▏",
            },
            scope = {
                show_start = false,
                show_end = false,
                show_exact_scope = false,
            },
            exclude = {
                filetypes = {
                    "help",
                    "startify",
                    "dashboard",
                    "packer",
                    "neogitstatus",
                    "NvimTree",
                    {
                        "j-hui/fidget.nvim",
                        opts = {
                            notification = {
                                window = {
                                    winblend = 0,
                                    normal_hl = "FloatBorder",
                                    override_vim_notify = false, -- let mini.notify handle vim.notify
                                },
                            },
                        },
                    },
                    "Trouble",
                },
            },
        },
    },

    -- Show key presses on screen
    -- {
    --     "NStefan002/screenkey.nvim",
    --     cmd = "Screenkey",
    --     version = "*",
    --     config = function()
    --         require("screenkey").setup({
    --             win_opts = {
    --                 width = 18,
    --                 height = 1,
    --                 title = "",
    --             },
    --         })
    --     end,
    -- },

    -- status bar
    -- {
    -- 	"mbbill/undotree",
    -- 	config = function()
    -- 		vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    -- 	end,
    -- },
}
