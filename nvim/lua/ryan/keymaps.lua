-- leader
vim.g.mapleader = ' '

vim.keymap.set('i', 'jk', '<ESC>', { desc = 'Exit insert mode' })

-- Move higlighted lines
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move highlighted lines up' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move highlighted lines down' })

-- Keep cursor in the same position
vim.keymap.set('n', 'J', 'mzJ`z', { desc = '' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = '???' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = '???' })

-- Keep search terms in the middle of the screen
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Go to next search term' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Go to previous search term' })

-- Clear search highlights
vim.keymap.set('n', '<leader>nh', ':nohl<CR>', { desc = 'Clear search highlights' })

-- Paste without losing current buffer
vim.keymap.set('x', '<leader>p', '"_dP', { desc = 'Paste, keeping the buffer' })

-- Delete into void register
vim.keymap.set('n', '<leader>d', '"_d', { desc = 'Delete text without copying to register' })
vim.keymap.set('v', '<leader>d', '"_d', { desc = 'Delete text without copying to register' })

-- Don't ever press 'Q'
vim.keymap.set('n', 'Q', '<nop>', { desc = 'Unbind Q' })

-- Quickfix navigation
vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz', { desc = '???' })
vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz', { desc = '???' })
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz', { desc = '???' })
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz', { desc = '???' })

-- Replace the current word
vim.keymap.set(
    'n',
    '<leader>s',
    [[:%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = 'Replace current word' }
)

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

-- Make file executable
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { desc = 'Make file executable', silent = true })
