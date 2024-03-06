-- Fuzzy finder
return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    -- or branch = '0.1.x'
    dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            'nvim-tree/nvim-web-devicons',
    },
    config = function()
        local telescope = require('telescope')
        local actions = require('telescope.actions')
        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end) 

        telescope.setup({
            defaults = {
                extensions = {
                    fzf = {
                        fuzzy = true,                    -- false will only do exact matching
                        override_generic_sorter = true,  -- override the generic sorter
                        override_file_sorter = true,     -- override the file sorter
                        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                    }
                }
            }
        })

        telescope.load_extension('fzf')
    end,
    keys = {
        { '<leader>pf', '<cmd>Telescope find_files<cr>', desc = 'Fuzzy find file by name' }
        { '<leader>pg', '<cmd>Telescope live_grep<cr>', desc = 'Fuzzy grep files' }
        { '<leader>pb', '<cmd>Telescope buffers<cr>', desc = 'Telescope open buffers' }
        { '<leader>ph', '<cmd>Telescope help_tags<cr>', desc = 'Telescope help tags' }
        { '<C-p>', '<cmd>Telescope git_files<cr>' desc = 'Telescope git files' }
    }
}

