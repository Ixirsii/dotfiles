-- -------------------------------------------------------------------------- --
--                                  Keybinds                                  --
-- -------------------------------------------------------------------------- --

-- leader
vim.g.mapleader = ' '

-- Move higlighted lines
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move highlighted lines up' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move highlighted lines down' })

-- Keep search terms in the middle of the screen
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Go to next search term' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Go to previous search term' })

-- Clear search highlights
vim.keymap.set('n', '<leader>nh', ':nohl<CR>', { desc = 'Clear search highlights' })

-- Don't ever press 'Q'
vim.keymap.set('n', 'Q', '<nop>', { desc = 'Unbind Q' })

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

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        -- show definition, references
        opts.desc = 'Show LSP references'
        vim.keymap.set('n', 'gR', '<cmd>Telescope lsp_references<CR>', opts)

        -- go to declaration
        opts.desc = 'Go to declaration'
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

        -- show lsp definition
        opts.desc = 'Show LSP definition'
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)

        -- show lsp implementations
        opts.desc = 'Show LSP implementations'
        vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)

        -- show lsp type definitions
        opts.desc = 'Show LSP type definitions'
        vim.keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<CR>', opts)

        -- see available code actions, in visual mode will apply to selection
        opts.desc = 'See available code actions'
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)

        -- smart rename
        opts.desc = 'Smart rename'
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

        -- show  diagnostics for file
        opts.desc = 'Show buffer diagnostics'
        vim.keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts)

        -- show diagnostics for line
        opts.desc = 'Show line diagnostics'
        vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)

        -- jump to previous diagnostic in buffer
        opts.desc = 'Go to previous diagnostic'
        vim.keymap.set('n', '[d', function()
            vim.diagnostic.jump({ count = -1, float = true })
        end, opts)

        -- jump to next diagnostic in buffer
        opts.desc = 'Go to next diagnostic'
        vim.keymap.set('n', ']d', function()
            vim.diagnostic.jump({ count = 1, float = true })
        end, opts)

        -- show documentation for what is under cursor
        opts.desc = 'Show documentation for what is under cursor'
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

        -- mapping to restart lsp if necessary
        opts.desc = 'Restart LSP'
        vim.keymap.set('n', '<leader>rs', ':LspRestart<CR>', opts)
    end,
})

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

-- Vim diagnostic signs
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = ' ',
            [vim.diagnostic.severity.WARN] = ' ',
            [vim.diagnostic.severity.HINT] = '󰠠 ',
            [vim.diagnostic.severity.INFO] = ' ',
        },
    },
})

-- -------------------------------------------------------------------------- --
--                            Lazy plugin manager                             --
-- -------------------------------------------------------------------------- --

require('config.lazy')
