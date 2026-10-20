return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "mrcjkb/rustaceanvim",
        { "fredrikaverpil/neotest-golang", version = "^2" },
    },
    opts = function()
        return {
            adapters = {
                require("rustaceanvim.neotest"),
                require("neotest-golang")({}),
            },
        }
    end,
    keys = {
        {
            "<leader>tt",
            function()
                require("neotest").run.run()
            end,
            desc = "Run nearest test",
        },
        {
            "<leader>tT",
            function()
                require("neotest").run.run(vim.fn.expand("%"))
            end,
            desc = "Run file tests",
        },
        {
            "<leader>tl",
            function()
                require("neotest").run.run_last()
            end,
            desc = "Run last test",
        },
        {
            "<leader>ts",
            function()
                require("neotest").summary.toggle()
            end,
            desc = "Toggle test summary",
        },
        {
            "<leader>tr",
            function()
                require("neotest").run.stop()
            end,
            desc = "Stop test",
        },
        {
            "<leader>tO",
            function()
                require("neotest").output_panel.toggle()
            end,
            desc = "Toggle test output panel",
        },
        {
            "<leader>te",
            function()
                require("neotest").output.open({ enter = true })
            end,
            desc = "Show test output",
        },
    },
}
