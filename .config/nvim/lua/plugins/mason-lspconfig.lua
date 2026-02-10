return {
    'mason-org/mason-lspconfig.nvim',

    dependencies = {
        'mason-org/mason.nvim',
        'neovim/nvim-lspconfig',
    },

    opts = {
        ensure_installed = {
            'bashls',
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
}
