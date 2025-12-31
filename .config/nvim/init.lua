-- -------------------------------------------------------------------------- --
--                                  Keybinds                                  --
-- -------------------------------------------------------------------------- --

-- leader
vim.g.mapleader = ' '

vim.keymap.set('i', 'jk', '<ESC>', { desc = 'Exit insert mode' })

-- Move higlighted lines
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move highlighted lines up' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move highlighted lines down' })

-- Keep search terms in the middle of the screen
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Go to next search term' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Go to previous search term' })

-- Clear search highlights
vim.keymap.set('n', '<leader>nh', ':nohl<CR>', { desc = 'Clear search highlights' })

-- Paste without losing current buffer
vim.keymap.set('x', '<leader>p', '"_dP', { desc = 'Paste, keeping the buffer' })

-- Don't ever press 'Q'
vim.keymap.set('n', 'Q', '<nop>', { desc = 'Unbind Q' })

-- Increment/decrement numbers
vim.keymap.set('n', '<leader>+', '<C-a>', { desc = 'Increment number' })
vim.keymap.set('n', '<leader>-', '<C-x>', { desc = 'Decrement number' })

-- Window management
vim.keymap.set('n', '<leader>sv', '<C-w>v', { desc = 'Split window vertically' })
vim.keymap.set('n', '<leader>sh', '<C-w>s', { desc = 'Split window horizontally' })
vim.keymap.set('n', '<leader>se', '<C-w>=', { desc = 'Make splits equal size' })
vim.keymap.set('n', '<leader>sx', '<cmd>close<CR>', { desc = 'Close current split' })

vim.keymap.set('n', '<leader>to', '<cmd>tabnew<CR>', { desc = 'Open new tab' })
vim.keymap.set('n', '<leader>tx', '<cmd>tabclose<CR>', { desc = 'Close current tab' })
vim.keymap.set('n', '<leader>tn', '<cmd>tabn<CR>', { desc = 'Go to next tab' })
vim.keymap.set('n', '<leader>tp', '<cmd>tabp<CR>', { desc = 'Go to previous tab' })
vim.keymap.set('n', '<leader>tf', '<cmd>tabnew %<CR>', { desc = 'Open current buffer in new tab' })

-- -------------------------------------------------------------------------- --
--                               Configuration                                --
-- -------------------------------------------------------------------------- --

-- Recommended settings from nvim-tree documentation
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Fat cursor
vim.opt.guicursor = ''

-- Relative line numbers
vim.opt.number = true
vim.opt.relativenumber = false

-- Tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

-- Disable line wrapping
vim.opt.wrap = true

-- Don't make backups, but keep undo history
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true

-- Incremental search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Colors
vim.opt.termguicolors = true
vim.opt.background = 'dark'

-- Backspace
vim.opt.backspace = 'indent,eol,start'

-- Clipboard
vim.opt.clipboard:append('unnamedplus')

-- Split windows
vim.opt.splitright = true
vim.opt.splitbelow = true

--
vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append('@-@')

-- Faster update time
vim.opt.updatetime = 50

-- Marker at 80 characters
vim.opt.colorcolumn = '80'

-- Format on save
vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])

-- -------------------------------------------------------------------------- --
--                            Lazy plugin manager                             --
-- -------------------------------------------------------------------------- --

require('config.lazy')
