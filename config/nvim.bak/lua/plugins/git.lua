return {
    -- { "rbong/vim-flog", cmd = { "Flog" } },
    -- {
    --     "akinsho/git-conflict.nvim",
    --     version = "*",
    --     event = "VeryLazy",
    --     config = function()
    --         require("config.git-conflict")
    --     end,
    -- },
    -- {
    --     "ruifm/gitlinker.nvim",
    --     event = "User InGitRepo",
    --     config = function()
    --         require("config.git-linker")
    --     end,
    -- },

    -- Show git change (change, delete, add) signs in vim sign column
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("config.gitsigns")
        end,
        event = "BufRead",
        version = "*",
    },
}
