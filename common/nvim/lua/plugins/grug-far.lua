return {
    "MagicDuck/grug-far.nvim",
    cmd = { "GrugFar", "GrugFarWithin" },
    opts = {},
    keys = {
        {
            "<leader>sr",
            function()
                require("grug-far").open()
            end,
            desc = "Search and replace",
        },
        {
            "<leader>sr",
            ":GrugFar<CR>",
            mode = "x",
            desc = "Search and replace selection",
        },
    },
}
