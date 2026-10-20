return {
    "folke/which-key.nvim",

    event = "VeryLazy",

    opts = {
        spec = {
            { "<leader>c", group = "Conform" },
            { "<leader>d", group = "Diagnostics" },
            { "<leader>f", group = "Find files" },
            { "<leader>g", group = "Git" },
            { "<leader>h", group = "Git hunks" },
            { "<leader>l", group = "LSP" },
            { "<leader>m", group = "Markdown" },
            { "<leader>r", group = "Rename / Rust" },
            { "<leader>s", group = "Search" },
            { "<leader>t", group = "Tests / tabs" },
        },
    },
}
