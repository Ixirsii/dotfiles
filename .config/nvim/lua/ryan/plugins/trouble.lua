return {
    'folke/trouble.nvim',

    dependencies = { 'nvim-tree/nvim-web-devicons' },

    keys = {
        { '<leader>xx', '<cmd>Trouble diagnostics toggle<CR>', desc = 'Open/close trouble diagnostics' },
        {
            '<leader>xX',
            '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
            desc = 'Open/close trouble buffer diagnostics',
        },
        { '<leader>xq', '<cmd>Trouble qflist toggle<CR>', desc = 'Open trouble quickfix list' },
        { '<leader>xl', '<cmd>Trouble loclist toggle<CR>', desc = 'Open trouble location list' },
    },

    opts = {},
}
