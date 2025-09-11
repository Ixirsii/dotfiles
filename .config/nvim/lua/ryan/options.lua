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
