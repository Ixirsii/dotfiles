return {
    'stevearc/conform.nvim',

    event = { 'BufReadPre', 'BufNewFile' },

    config = function()
        local conform = require('conform')

        conform.setup({
            formatters_by_ft = {
                css = { 'prettier' },
                graphql = { 'prettier' },
                html = { 'prettier' },
                javascript = { 'prettier' },
                json = { 'prettier' },
                lua = { 'stylua' },
                markdown = { 'prettier' },
                python = { 'isort', 'black' },
                typescript = { 'prettier' },
                yaml = { 'prettier' },
            },

            format_on_save = {
                lsp_fallback = false,
                async = false,
                timeout_ms = 1000,
            },
        })

        vim.keymap.set({ 'n', 'v' }, '<leader>mp', function()
            conform.format({
                lsp_fallback = false,
                async = false,
                timeout_ms = 1000,
            })
        end, { desc = 'Format file or range (in visual mode' })
    end,
}
