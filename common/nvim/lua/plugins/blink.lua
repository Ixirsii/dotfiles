return {
    "saghen/blink.cmp",
    version = "1.*",
    event = "InsertEnter",
    dependencies = {
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            build = "make install_jsregexp",
            dependencies = { "rafamadriz/friendly-snippets" },
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        },
    },
    opts = {
        keymap = {
            preset = "default",
            ["<C-k>"] = { "select_prev", "fallback" },
            ["<C-j>"] = { "select_next", "fallback" },
            ["<C-e>"] = { "cancel", "fallback" },
            ["<CR>"] = { "select_and_accept", "fallback" },
        },
        snippets = { preset = "luasnip" },
        sources = { default = { "lsp", "snippets", "buffer", "path" } },
        completion = {
            list = { selection = { preselect = false, auto_insert = false } },
            accept = { auto_brackets = { enabled = true } },
            documentation = { auto_show = true },
            menu = {
                draw = {
                    columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
                },
            },
        },
        -- Prefer native matching, with a portable fallback when binaries are unavailable.
        fuzzy = { implementation = "prefer_rust" },
    },
}
