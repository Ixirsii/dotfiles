-- -------------------------------------------------------------------------- --
--                                  Keybinds                                  --
-- -------------------------------------------------------------------------- --

local keymap = vim.keymap

-- leader
vim.g.mapleader = " "

-- Move higlighted lines
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move highlighted lines up" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move highlighted lines down" })

-- Keep search terms in the middle of the screen
keymap.set("n", "n", "nzzzv", { desc = "Go to next search term" })
keymap.set("n", "N", "Nzzzv", { desc = "Go to previous search term" })

-- Clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Don't ever press 'Q'
keymap.set("n", "Q", "<nop>", { desc = "Unbind Q" })

-- Window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        -- View documentation
        keymap.set(
            "n",
            "K",
            function()
                vim.lsp.buf.hover({ border = "rounded" })
            end,
            { buffer = ev.buf, desc = "Show documentation for symbol under cursor", silent = true }
        )

        -- See available code actions
        keymap.set(
            { "n", "v" },
            "<leader>lca",
            vim.lsp.buf.code_action,
            { buffer = ev.buf, desc = "See available code actions", silent = true }
        )

        -- Restart LSP
        keymap.set(
            "n",
            "<leader>lrs",
            "<cmd>lsp restart<CR>",
            { buffer = ev.buf, desc = "Restart LSP", silent = true }
        )

        -- Rename symbol
        keymap.set(
            "n",
            "<leader>rn",
            vim.lsp.buf.rename,
            { buffer = ev.buf, desc = "Smart rename", silent = true }
        )

        -- Diagnostics for line
        keymap.set(
            "n",
            "<leader>dd",
            vim.diagnostic.open_float,
            { buffer = ev.buf, desc = "Show line diagnostics", silent = true }
        )

        -- Go to previous diagnostic
        keymap.set("n", "[d", function()
            vim.diagnostic.jump({ count = -1, float = true })
        end, { buffer = ev.buf, desc = "Go to previous diagnostic", silent = true })

        -- Go to next diagnostic
        keymap.set("n", "]d", function()
            vim.diagnostic.jump({ count = 1, float = true })
        end, { buffer = ev.buf, desc = "Go to next diagnostic", silent = true })
    end,
})

-- -------------------------------------------------------------------------- --
--                               Configuration                                --
-- -------------------------------------------------------------------------- --

local opt = vim.opt

-- Faster update time
opt.updatetime = 50

-- 24 bit color
opt.termguicolors = true

-- Clipboard
opt.clipboard = "unnamedplus"

-- Editor width
opt.colorcolumn = "+1"
opt.textwidth = 80

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Fat cursor
--opt.guicursor = ""

-- Tabs
opt.tabstop = 4
opt.softtabstop = -1
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Don't make backups, but keep undo history
opt.swapfile = false
opt.backup = false
opt.undodir = vim.fn.expand("~/.vim/undodir")
opt.undofile = true

-- Split windows
opt.splitright = true
opt.splitbelow = true

-- Number of lines to keep above and below the cursor
opt.scrolloff = 8

-- Display signs in the number column
opt.signcolumn = "number"

-- Vim diagnostic signs
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "󰠠",
            [vim.diagnostic.severity.INFO] = "",
        },
    },
})

-- -------------------------------------------------------------------------- --
--                            Lazy plugin manager                             --
-- -------------------------------------------------------------------------- --

require("config.filetypes")
require("config.lazy")
