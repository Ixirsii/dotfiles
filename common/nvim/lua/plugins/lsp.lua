local servers = {
    "bashls",
    "cssls",
    "docker_language_server",
    "eslint",
    "gopls",
    "html",
    "hyprls",
    "jsonls",
    "lua_ls",
    "ols",
    "sqls",
    "tailwindcss",
    "taplo",
    "ts_ls",
    "yamlls",
}

return {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    config = function()
        vim.lsp.config("*", {
            capabilities = require("blink.cmp").get_lsp_capabilities(),
        })
        vim.lsp.enable(servers)
    end,
}
