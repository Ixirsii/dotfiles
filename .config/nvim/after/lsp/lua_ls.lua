vim.lsp.config('lua_ls', {
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
