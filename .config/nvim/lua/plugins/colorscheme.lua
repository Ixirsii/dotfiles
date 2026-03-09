return {
    {
        'catppuccin/nvim',

        name = 'catppuccin',
        lazy = false,
        priority = 1000,

        config = function()
            require('catppuccin').setup({
                auto_integrations = true,
                flavor = 'mocha',
                float = {
                    transparent = true, -- enable transparent floating windows
                    solid = false, -- use solid styling for floating windows, see |winborder|
                },
            })

            vim.cmd('colorscheme catppuccin')
        end,
    },
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
    },
}
