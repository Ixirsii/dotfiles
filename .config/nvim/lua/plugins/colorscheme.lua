return {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,

    config = function()
        require('catppuccin').setup({
            flavor = 'mocha',
            integrations = {
                mason = true,
                nvimtree = true,
                telescope = {
                    enabled = true,
                },
                treesitter = true,
            },
        })

        vim.cmd('colorscheme catppuccin')
    end,
}
