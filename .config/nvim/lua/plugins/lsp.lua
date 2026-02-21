return {
    {
        'mason-org/mason-lspconfig.nvim',

        dependencies = {
            {
                'mason-org/mason.nvim',

                opts = {
                    ui = {
                        icons = {
                            package_installed = '✓',
                            package_pending = '➜',
                            package_uninstalled = '✗',
                        },
                    },
                },
            },

            'neovim/nvim-lspconfig',
        },

        opts = {
            ensure_installed = {
                'bashls',
                'eslint',
                'html',
                'jsonls',
                'lua_ls',
                'marksman',
                'ols',
                'rust_analyzer',
                'sqlls',
                'tailwindcss',
                'taplo',
                'ts_ls',
                'yamlls',
            },
        },
    },
    {
        'WhoIsSethDaniel/mason-tool-installer.nvim',

        dependencies = {
            'mason-org/mason.nvim',
        },

        opts = {
            ensure_installed = {
                'clang-format',
                'eslint_d',
                'jsonlint',
                'markdownlint',
                'prettierd',
                'stylua',
            },
        },
    },
    {
        'hrsh7th/cmp-nvim-lsp',

        event = { 'BufReadPre', 'BufNewFile' },

        dependencies = {
            { 'antosha417/nvim-lsp-file-operations', config = true },
            { 'folke/lazydev.nvim', opts = {} },
        },

        config = function()
            local cmp_nvim_lsp = require('cmp_nvim_lsp')

            -- used to enable autocompletion (assign to every lsp server config)
            local capabilities = cmp_nvim_lsp.default_capabilities()

            vim.lsp.config('*', {
                capabilities = capabilities,
            })
        end,
    },
}
