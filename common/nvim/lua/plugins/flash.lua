return {
    "folke/flash.nvim",
    opts = {
        modes = {
            char = { enabled = false },
        },
    },
    keys = {
        {
            "<leader>j",
            mode = { "n", "x", "o" },
            function()
                require("flash").jump()
            end,
            desc = "Flash jump",
        },
        {
            "<leader>J",
            mode = { "n", "x", "o" },
            function()
                require("flash").treesitter()
            end,
            desc = "Flash Treesitter selection",
        },
    },
}
