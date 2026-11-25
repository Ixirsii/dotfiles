return {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" },
    opts = {},
    keys = {
        { "<leader>mr", "<cmd>RenderMarkdown toggle<CR>", desc = "Toggle Markdown rendering" },
    },
}
