return {
    'mfussenegger/nvim-lint',

    event = { 'BufReadPre', 'BufNewFile' },

    config = function()
        local lint = require('lint')

        lint.linters_by_ft = {
            fish = { 'fish' },
            javascript = { 'eslint_d' },
            javascriptreact = { 'eslint_d' },
            json = { 'jsonlint' },
            markdown = { 'markdownlint' },
            typescript = { 'eslint_d' },
            typescriptreact = { 'eslint_d' },
            zsh = { 'zsh' },
        }

        vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
