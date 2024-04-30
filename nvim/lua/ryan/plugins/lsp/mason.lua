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
                'gradle_ls',
                'graphql',
                'html',
                'jdtls',
                'kotlin_language_server',
                'lua_ls',
                'marksman',
                'pyright',
                'rust_analyzer',
                'sqlls',
                'tailwindcss',
                'taplo',
                'tsserver',
                'yamlls',
            },
        })

        require('mason-tool-installer').setup({
            ensure_installed = {
                'ast-grep', -- Multi-language linter and formatter
                'black', -- Python formatter
                'clang-format', -- Multi-language formatter
                'checkstyle', -- Java linter
                'eslint_d', -- JavaScript/TypeScript linter
                'google-java-format', -- Java formatter
                'isort', -- Python formatter
                'ktlint', -- Kotlin formatter
                'prettier', -- JavaScript/TypeScript formatter
                'pylint', -- Python linter
                'snyk', -- Mulit-language vulnerability scanner
                'sonarlint-language-server', -- Java linter
                'stylua', -- Lua formatter
                'trivy', -- Multi-language vulnerability scanner
            },
        })
    end,
}
