return {
    {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },
        cmd = "ConformInfo",
        keys = {
            {
                "<leader>cf",
                function()
                    require("conform").format({ async = true, lsp_format = "fallback" })
                end,
                mode = { "n", "v" },
                desc = "Format buffer",
            },
        },
        opts = {
            formatters_by_ft = {
                bash = { "shfmt" },
                css = { "prettier" },
                go = { "goimports", "gofmt", stop_after_first = true },
                html = { "prettier" },
                javascript = { "prettier" },
                javascriptreact = { "prettier" },
                json = { "prettier" },
                jsonc = { "prettier" },
                less = { "prettier" },
                lua = { "stylua" },
                markdown = { "prettier" },
                odin = { "odinfmt" },
                rust = { "rustfmt" },
                scss = { "prettier" },
                sh = { "shfmt" },
                toml = { "taplo" },
                typescript = { "prettier" },
                typescriptreact = { "prettier" },
                yaml = { "prettier" },
                zsh = { "shfmt" },
            },
            format_on_save = {
                timeout_ms = 1000,
                lsp_format = "fallback",
            },
        },
    },
}
