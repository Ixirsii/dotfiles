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

            treesitter.setup({
                additional_vim_regex_highlighting = false,
                highlight = { enable = true },
                indent = { enable = true },
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
        "nvim-treesitter/nvim-treesitter-context",
    },
}
