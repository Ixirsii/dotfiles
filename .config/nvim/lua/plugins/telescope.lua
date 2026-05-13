return {
    "nvim-telescope/telescope.nvim",

    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
        },
        "nvim-tree/nvim-web-devicons",
        "folke/todo-comments.nvim",
    },

    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    },
                },

                path_display = { "smart" },
            },
            extensions = {
                fzf = {
                    fuzzy = true, -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true, -- override the file sorter
                    case_mode = "smart_case", -- or 'ignore_case' or 'respect_case'
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                },
                grep_string = {
                    additional_args = { "--hidden" },
                },
                live_grep = {
                    additional_args = { "--hidden" },
                },
            },
        })

        telescope.load_extension("fzf")
    end,

    keys = {
        { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Fuzzy find file by name" },
        { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Fuzzy find recent files" },
        { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Find string" },
        { "<leader>fc", "<cmd>Telescope grep_string<CR>", desc = "Find string under cursor" },
        { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Telescope open buffers" },
        { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Telescope help tags" },
        { "<leader>fs", "<cmd>Telescope git_files<CR>", desc = "Telescope git files" },
        { "<leader>ft", "<cmd>TodoTelescope<CR>", desc = "Find todos" },
    },
}
