return {
    'gbprod/substitute.nvim',

    event = { 'BufReadPre', 'BufNewFile' },

    config = function()
        local substitute = require('substitute')

        substitute.setup()

        vim.keymap.set('n', 's', substitute.operator, { desc = 'Substitue with motion' })
        vim.keymap.set('n', 'ss', substitute.line, { desc = 'Substitue line' })
        vim.keymap.set('n', 'S', substitute.eol, { desc = 'Substitue to end of line' })
        vim.keymap.set('x', 's', substitute.visual, { desc = 'Substitue in visual mode' })
    end,
}
