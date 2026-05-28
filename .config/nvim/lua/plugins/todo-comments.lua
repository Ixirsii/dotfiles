return {
    "folke/todo-comments.nvim",

    dependencies = { "nvim-lua/plenary.nvim" },

    keys = {
        {
            "t[",
            function()
                require("todo-comments").jump_prev()
            end,
            "Previous todo comment",
        },
        {
            "t]",
            function()
                require("todo-comments").jump_next()
            end,
            "Next todo comment",
        },
        {
            "<leader>st",
            function()
                Snacks.picker.todo_comments()
            end,
            desc = "Todo",
        },
    },
}
