return {
    "dlyongemallo/diffview-plus.nvim",
    cmd = {
        "DiffviewOpen",
        "DiffviewFileHistory",
        "DiffviewDiffFiles",
        "DiffviewMergeFiles",
        "DiffviewDiffDirs",
    },
    keys = {
        { "<leader>gD", "<cmd>DiffviewOpen<CR>", desc = "Git Diff View" },
    },
    opts = {},
}
