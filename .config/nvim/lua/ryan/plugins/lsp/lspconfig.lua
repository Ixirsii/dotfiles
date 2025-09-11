return {
    'neovim/nvim-lspconfig',

    event = { 'BufReadPre', 'BufNewFile' },

    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        { 'antosha417/nvim-lsp-file-operations', config = true },
        { 'folke/neodev.nvim', opts = {} },
    },

    config = function()
        local lspconfig = require('lspconfig')
        local mason_lspconfig = require('mason-lspconfig')
        local cmp_nvim_lsp = require('cmp_nvim_lsp')

        -- used to enable autocompletion (assign to every lsp server config)
        local capabilities = cmp_nvim_lsp.default_capabilities()

        vim.diagnostic.config({
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = ' ',
                    [vim.diagnostic.severity.WARN] = ' ',
                    [vim.diagnostic.severity.HINT] = '󰠠 ',
                    [vim.diagnostic.severity.INFO] = ' ',
                },
            },
        })

        mason_lspconfig.setup({
            -- default handler for installed servers
            function(server_name)
                lspconfig[server_name].setup({
                    capabilities = capabilities,
                })
            end,

            ['graphql'] = function()
                -- configure graphql language server
                lspconfig['graphql'].setup({
                    capabilities = capabilities,
                    filetypes = { 'graphql', 'gql' },
                })
            end,

            ['lua_ls'] = function()
                -- configure lua server (with special settings)
                lspconfig['lua_ls'].setup({
                    capabilities = capabilities,
                    settings = {
                        Lua = {
                            -- make the language server recognize vim global
                            diagnostics = {
                                globals = { 'vim' },
                            },
                            completion = {
                                callSnippet = 'Replace',
                            },
                        },
                    },
                })
            end,
        })
    end,

    keys = {
        { '<leader>ca', vim.lsp.buf.code_action, desc = 'See available code actions' },
        { '<leader>d', vim.diagnostic.open_float, desc = 'Show line diagnostics' },
        { '<leader>gD', vim.lsp.buf.declaration, desc = 'Go to declaration' },
        { '<leader>k', vim.lsp.buf.hover, desc = 'Show documentation' },
        { '<leader>rn', vim.lsp.buf.rename, desc = 'Smart rename' },
        { '<leader>rs', '<cmd>LspRestart<CR>', desc = 'Restart LSP' },
        { '<leader>[d', vim.diagnostic.goto_prev, desc = 'Go to previous diagnostic' },
        { '<leader>]d', vim.diagnostic.goto_next, desc = 'Go to next diagnostic' },
    },

    opts = {
        servers = {
            cssls = { settings = { css = { lint = { unknownAtRules = 'ignore' } } } },
        },
    },
}
