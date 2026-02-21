-- Syntax highlighting
return {
    'nvim-treesitter/nvim-treesitter',

    branch = 'main',
    build = ':TSUpdate',
    event = { 'BufReadPre', 'BufNewFile' },
    lazy = false,

    dependencies = {
        'windwp/nvim-ts-autotag',
    },

    config = function()
        local treesitter = require('nvim-treesitter')

        treesitter.setup({
            highlight = { enable = true },
            indent = { enable = true },
        })
        treesitter.install({
            'bash',
            'c',
            'cpp',
            'css',
            'desktop',
            'fish',
            'git_config',
            'git_rebase',
            'gitattributes',
            'gitcommit',
            'gitignore',
            'go',
            'html',
            'hyprlang',
            'java',
            'javascript',
            'json',
            'kotlin',
            'latex',
            'lua',
            'markdown',
            'odin',
            'regex',
            'rust',
            'scss',
            'svelte',
            'tsx',
            'typescript',
            'typst',
            'vim',
            'vimdoc',
            'vue',
            'yaml',
            'zsh',
        })
    end,
}
