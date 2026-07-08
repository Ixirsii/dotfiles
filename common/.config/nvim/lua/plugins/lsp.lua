return {
    {
        "mason-org/mason-lspconfig.nvim",

        dependencies = {
            {
                "mason-org/mason.nvim",

                opts = {
                    ui = {
                        icons = {
                            package_installed = "✓",
                            package_pending = "➜",
                            package_uninstalled = "✗",
                        },
                    },
                },
            },

            "neovim/nvim-lspconfig",
        },

        opts = {
            ensure_installed = {
                "bashls",
                "eslint",
                "html",
                "hyprls",
                "jsonls",
                "lua_ls",
                "marksman",
                "ols",
                "rust_analyzer",
                "sqlls",
                "tailwindcss",
                "taplo",
                "ts_ls",
                "yamlls",
            },
        },
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",

        dependencies = {
            "mason-org/mason.nvim",
        },

        opts = {
            ensure_installed = {
                "clang-format",
                "eslint_d",
                "jsonlint",
                "markdownlint",
                "prettierd",
                "stylua",
            },
        },
    },
    {
        "hrsh7th/nvim-cmp",

        event = "InsertEnter",

        dependencies = {
            "hrsh7th/cmp-buffer", -- Source for text in buffer
            "hrsh7th/cmp-path", -- Source for file system paths
            {
                "L3MON4D3/LuaSnip",
                version = "v2.*",
                build = "make install_jsregexp",
            },
            "saadparwaiz1/cmp_luasnip", -- Autocompletions
            "rafamadriz/friendly-snippets", -- Useful snippets
            "onsails/lspkind.nvim", -- VSCode like pictograms
        },

        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            local lspkind = require("lspkind")

            -- Load VSCode style snippets from installed plugins (e.g. friendly-snippets)
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                completions = {
                    completeopt = "menu,menuone,preview,noselect",
                },

                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },

                mapping = cmp.mapping.preset.insert({
                    ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
                    ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
                    ["<C-e>"] = cmp.mapping.abort(), -- close completion window
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),

                -- sources for autocompletion
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" }, -- snippets
                    { name = "buffer" }, -- text within current buffer
                    { name = "path" }, -- file system paths
                }),

                -- configure lspkind for vs-code like pictograms in completion menu
                formatting = {
                    fields = { "abbr", "icon", "kind", "menu" },
                    format = lspkind.cmp_format({
                        maxwidth = {
                            menu = 50, -- leading text (labelDetails)
                            abbr = 50, -- actual suggestion item
                        },
                        ellipsis_char = "...",
                        show_labelDetails = true, -- show labelDetails in menu. Disabled by default
                    }),
                },
            })
        end,
    },
    {
        "hrsh7th/cmp-nvim-lsp",

        event = { "BufReadPre", "BufNewFile" },

        config = function()
            local cmp_nvim_lsp = require("cmp_nvim_lsp")

            -- used to enable autocompletion (assign to every lsp server config)
            local capabilities = cmp_nvim_lsp.default_capabilities()

            vim.lsp.config("*", {
                capabilities = capabilities,
            })
        end,
    },
}
