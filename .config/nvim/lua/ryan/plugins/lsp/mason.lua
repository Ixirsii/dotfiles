return {
    'williamboman/mason.nvim',

    dependencies = {
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
    },

    config = function()
        require('mason').setup({
            ui = {
                icons = {
                    package_installed = '✓',
                    package_pending = '➜',
                    package_uninstalled = '✗',
                },
            },
        })

        require('mason-lspconfig').setup({
            -- list of servers for mason to install
            ensure_installed = {
                'bashls',
                'cssls',
                'graphql',
                'html',
                'lua_ls',
                'rust_analyzer',
                'sqlls',
                'tailwindcss',
                'taplo',
                'ts_ls',
                'yamlls',
            },
        })

        require('mason-tool-installer').setup({
            ensure_installed = {
                'ast-grep', -- Multi-language linter and formatter
                'clang-format', -- Multi-language formatter
                'eslint_d', -- JavaScript/TypeScript linter
                'prettier', -- JavaScript/TypeScript formatter
                'stylua', -- Lua formatter
            },
        })
    end,
}
