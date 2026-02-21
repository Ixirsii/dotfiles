return {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },

    config = function()
        require('nvim-tree').setup({
            -- Disable window picker for explorer to work well with window splits
            actions = {
                open_file = {
                    window_picker = {
                        enable = false,
                    },
                },
            },

            filters = {
                custom = { '.DS_Store' },
                git_ignored = false,
            },

            renderer = {
                indent_markers = {
                    enable = true,
                },
                icons = {
                    glyphs = {
                        folder = {
                            arrow_closed = '', -- arrow when folder is closed
                            arrow_open = '', -- arrow when folder is open
                        },
                    },
                },
            },

            view = {
                number = true,
                width = 50,
            },
        })
    end,

    keys = {
        { '<leader>ee', '<cmd>NvimTreeToggle<CR>', desc = 'Toggle file explorer' },
        { '<leader>ef', '<cmd>NvimTreeFindFileToggle<CR>', desc = 'Toggle file explorer on current file' },
        { '<leader>ec', '<cmd>NvimTreeCollapse<CR>', desc = 'Collapse file explorer' },
        { '<leader>er', '<cmd>NvimTreeRefresh<CR>', desc = 'Refresh file explorer' },
    },

    lazy = false,
}
