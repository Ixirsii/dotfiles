-- Syntax highlighting
return {
    {
        "nvim-treesitter/nvim-treesitter",

        branch = "main",
        build = ":TSUpdate",
        lazy = false,

        dependencies = {
            "windwp/nvim-ts-autotag",
        },

        config = function()
            local treesitter = require("nvim-treesitter")

            treesitter.setup({})
            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true }),
                callback = function(ev)
                    -- Keep normal syntax and indentation for filetypes without a parser.
                    local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
                    if not lang or not pcall(vim.treesitter.start, ev.buf, lang) then
                        return
                    end
                    if vim.treesitter.query.get(lang, "indents") then
                        vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end,
            })
            treesitter.install({
                "bash",
                "c",
                "cpp",
                "css",
                "desktop",
                "dockerfile",
                "git_config",
                "git_rebase",
                "gitattributes",
                "gitcommit",
                "gitignore",
                "go",
                "html",
                "hyprlang",
                "java",
                "javascript",
                "json",
                "jsx",
                "kotlin",
                "latex",
                "lua",
                "markdown",
                "markdown_inline",
                "odin",
                "regex",
                "rust",
                "sql",
                "toml",
                "typescript",
                "typst",
                "vim",
                "vimdoc",
                "yaml",
                "zsh",
            })
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        opts = {},
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
    },
}
