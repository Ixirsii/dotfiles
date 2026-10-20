return {
    "folke/trouble.nvim",

    dependencies = { "nvim-tree/nvim-web-devicons" },

    opts = {
        focus = true,
        win = { type = "split", position = "bottom" },
    },

    keys = {
        {
            "<leader>dp",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Project diagnostics (Trouble)",
        },
        {
            "<leader>db",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Buffer diagnostics (Trouble)",
        },
    },

    specs = {
        "folke/snacks.nvim",

        opts = function(_, opts)
            return vim.tbl_deep_extend("force", opts or {}, {
                picker = {
                    actions = require("trouble.sources.snacks").actions,
                    win = {
                        input = {
                            keys = {
                                ["<c-t>"] = {
                                    "trouble_open",
                                    mode = { "n", "i" },
                                },
                            },
                        },
                    },
                },
            })
        end,
    },
}
