-- colorscheme
require("catppuccin").setup({
    flavor = "mocha",
    integrations = {
        mason = true,
        nvimtree = true,
        telescope = {
            enabled = true,
            -- style = "nvchad"
        },
        treesitter = true,
    }
})

vim.cmd.colorscheme('catppuccin')

