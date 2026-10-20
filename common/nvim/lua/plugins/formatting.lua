local function lsp_format(bufnr)
    for _, formatter in ipairs(require("conform").list_formatters(bufnr)) do
        if formatter.available and formatter.name ~= "trim_newlines" then
            return "fallback"
        end
    end
    -- Keep LSP formatting when newline cleanup is the only available formatter.
    return "first"
end

return {
    {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },
        cmd = "ConformInfo",
        keys = {
            {
                "<leader>cf",
                function()
                    require("conform").format({ async = true, lsp_format = lsp_format(0) })
                end,
                mode = { "n", "v" },
                desc = "Format buffer",
            },
        },
        opts = {
            formatters_by_ft = {
                ["*"] = { "trim_newlines" },
                bash = { "shfmt" },
                css = { "prettier" },
                go = function(bufnr)
                    if require("conform").get_formatter_info("goimports", bufnr).available then
                        return { "goimports" }
                    end
                    return { "gofmt" }
                end,
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
            format_on_save = function(bufnr)
                return { timeout_ms = 1000, lsp_format = lsp_format(bufnr) }
            end,
        },
    },
}
