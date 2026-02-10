return {
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    dependencies = {
        'mason-org/mason.nvim',
    },

    opts = {
        ensure_installed = {
            'ast-grep', -- Multi-language linter and formatter
            'clang-format', -- Multi-language formatter
            'eslint_d', -- JavaScript/TypeScript linter
            'jsonlint', -- JSON linter
            'markdownlint', -- Markdown linter and formatter
            'prettier', -- JavaScript/TypeScript formatter
            'prettierd', -- Prettier daemon
            'stylua', -- Lua formatter
        },
    },
}
