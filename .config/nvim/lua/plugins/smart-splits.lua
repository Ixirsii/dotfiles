return {
    "mrjones2014/smart-splits.nvim",

    lazy = false,

    keys = {
        { "<C-A-h>", "<cmd>SmartResizeLeft 5<CR>", desc = "Resize pane left by 5" },
        { "<C-S-A-h>", "<cmd>SmartResizeLeft 1<CR>", desc = "Resize pane left by 1" },
        { "<C-A-j>", "<cmd>SmartResizeDown 5<CR>", desc = "Resize pane down by 5" },
        { "<C-S-A-j>", "<cmd>SmartResizeDown 1<CR>", desc = "Resize pane down by 1" },
        { "<C-A-k>", "<cmd>SmartResizeUp 5<CR>", desc = "Resize pane up by 5" },
        { "<C-S-k>", "<cmd>SmartResizeUp 1<CR>", desc = "Resize pane up by 1" },
        { "<C-A-l>", "<cmd>SmartResizeRight 5<CR>", desc = "Resize pane right by 5" },
        { "<C-S-A-l>", "<cmd>SmartResizeRight 1<CR>", desc = "Resize pane right by 1" },
        { "<C-h>", "<cmd>SmartCursorMoveLeft<CR>", desc = "Navigate left" },
        { "<C-j>", "<cmd>SmartCursorMoveDown<CR>", desc = "Navigate down" },
        { "<C-k>", "<cmd>SmartCursorMoveUp<CR>", desc = "Navigate up" },
        { "<C-l>", "<cmd>SmartCursorMoveRight<CR>", desc = "Navigate right" },
        { "<leader><leader>h", "<cmd>SmartSwapLeft<CR>", desc = "Swap buffer left" },
        { "<leader><leader>j", "<cmd>SmartSwapDown<CR>", desc = "Swap buffer down" },
        { "<leader><leader>k", "<cmd>SmartSwapUp<CR>", desc = "Swap buffer up" },
        { "<leader><leader>l", "<cmd>SmartSwapRight<CR>", desc = "Swap buffer right" },
    },
}
