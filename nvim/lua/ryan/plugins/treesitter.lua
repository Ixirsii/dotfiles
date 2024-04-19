return {
    -- Syntax highlighting
    'nvim-treesitter/nvim-treesitter',

    build = ':TSUpdate',

    dependencies = {
        'windwp/nvim-ts-autotag',
    },

    event = { 'BufReadPre', 'BufNewFile' },

    config = function()
        require('nvim-treesitter.configs').setup({
            -- A list of parser names, or 'all' (the five listed parsers should always be installed)
            ensure_installed = {
                'bash',
                'c',
                'css',
                'gitignore',
                'html',
                'java',
                'javascript',
                'json',
                'lua',
                'markdown',
                'query',
                'rust',
                'tsx',
                'typescript',
                'vim',
                'vimdoc',
                'yaml',
            },

            auto_tag = {
                enable = true,
            },

            incremental_selection = {
                enable = true,

                keymaps = {
                    init_selection = '<C-space>',
                    node_incremental = '<C-space>',
                    scope_incremental = false,
                    node_decremental = '<bs>'
                },
            },

            indent = {
                enable = true
            },

            highlight = {
                enable = true,

                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = { 'markdown' },
            },
        })
    end,
}
