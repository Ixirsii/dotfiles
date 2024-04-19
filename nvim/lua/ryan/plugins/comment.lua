return {
    'numToStr/Comment.nvim',

    event = { 'BufReadPre', 'BufNewFile' },

    dependencies = {
        'JoosepAlviste/nvim-ts-context-commentstring',
    },

    config = function()
        local comment = require('Comment')
        local ts_context_comment_string = require('ts_context_commentstring.integrations.comment_nvim')

        comment.setup({
            -- Comment tsx, jsx, html files
            pre_hook = ts_context_comment_string.create_pre_hook(),
        })
    end,
}
