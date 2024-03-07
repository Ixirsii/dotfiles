local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

return {
    -- Better file navigation
    'ThePrimeagen/harpoon',

    keys = {
        { "<leader>a", mark.add_file, desc = 'Add file to harpoon' },
        { "<C-e>", ui.toggle_quick_menu, 'Harpoon menu' },
    }
}
