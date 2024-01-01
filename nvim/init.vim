"
"                                      (_)
"                 _ __   ___  _____   ___ _ __ ___  _ __ ___
"                | '_ \ / _ \/ _ \ \ / / | '_ ` _ \| '__/ __|
"                | | | |  __/ (_) \ V /| | | | | | | | | (__
"                |_| |_|\___|\___/ \_/ |_|_| |_| |_|_|  \___|
"
" Author: Ryan Porterfield
" Source: https://bitbucket.org/ShadowHawk54/dotfiles/src/master/config/nvim

" Setup language {{{
" Solve some plugins incompatibilities
language en_US.UTF-8
" }}}

" vim-plug {{{
" Autoinstall Plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " Autocompletion
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'deoplete-plugins/deoplete-clang'
    Plug 'deoplete-plugins/deoplete-tag'
    Plug 'deoplete-plugins/deoplete-zsh'
    Plug 'jiangmiao/auto-pairs'

    " Syntax highlighting
    Plug 'plasticboy/vim-markdown'
    Plug 'scrooloose/syntastic'
    Plug 'sheerun/vim-polyglot'
    Plug 'vim-scripts/hexHighlight.vim'
    Plug 'Yggdroot/indentline'
    Plug 'w0rp/ale'

    " File browser
    Plug 'weynhamz/vim-plugin-minibufexpl'
    Plug 'scrooloose/nerdtree'

    " DCVS
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'

    " Color editing
    Plug 'Rykka/colorv.vim'

    " GUI
    Plug 'trevordmiller/nova-vim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " TMUX integration
    Plug 'christoomey/vim-tmux-navigator'

" call PlugInstall to install new plugins
call plug#end()
" }}}

" {{{ Setup
filetype plugin indent on      " Indent and plugins by filetype
syntax on
set number
set relativenumber
set textwidth=80
set colorcolumn=80
set scrolloff=3             " keep 3 context lines above and below the cursor
set dictionary+=/usr/share/dict/words
set dictionary+=/usr/share/dict/american-english
set spell spelllang=en_us

" <Leader> & <LocalLeader> mapping {{{
let mapleader=','
let maplocalleader= ' '
" }}}

" Edit/reload init.vim {{{
map <silent><leader>ev :edit ~/.config/nvim/init.vim<CR>
map <silent><leader>sv :source ~/.config/nvim/init.vim<CR>:filetype detect<CR>:exe ":echo 'init.vim reloaded'"<CR>
" }}}

" Basic options {{{
scriptencoding utf-8
set autoread                    " update a open file edited outside of Vim
set backspace=indent,eol,start  " defines the backspace key behavior
set cursorline                  " highlight the line under the cursor
set encoding=utf-8              " setup the encoding to UTF-8
set fillchars+=vert:│           " better looking for windows separator
set go-=T                       " hide the toolbar
set go-=m                       " hide the menu
set go-=rRlLbh                  " hide all the scrollbars
set hidden                      " hide the inactive buffers
set lazyredraw                  " only redraws if it is needed
set ls=2                        " status line always visible
set ruler                       " sets a permanent rule
set showcmd                     " shows partial commands
set title                       " set the terminal title to the current file
set ttimeoutlen=0               " toggle between modes almost instantly
set ttyfast                     " better screen redraw
"set virtualedit=all             " to edit where there is no actual character
set visualbell                  " turn on the visual bell
" }}}

" Searching {{{
set incsearch                   " incremental searching
set showmatch                   " show pairs match
set hlsearch                    " highlight search results
set smartcase                   " smart case ignore
set ignorecase                  " ignore case letters
set gdefault                    " substitutue all matches in a line
nnoremap / /\v
vnoremap / /\v
" }}}

" History and permanent undo levels {{{
set history=1000
set undofile
set undoreload=1000
" }}}

" Make a dir if no exists {{{
function! MakeDirIfNoExists(path)
    if !isdirectory(expand(a:path))
        call mkdir(expand(a:path), "p")
    endif
endfunction
" }}}

" Backups {{{
set backup
set noswapfile
set backupdir=$HOME/.nvim/tmp/backup/
set undodir=$HOME/.nvim/tmp/undo/
set directory=$HOME/.nvim/tmp/swap/
set viminfo+=n$HOME/.nvim/tmp/viminfo

" make this dirs if no exists previously
silent! call MakeDirIfNoExists(&undodir)
silent! call MakeDirIfNoExists(&backupdir)
silent! call MakeDirIfNoExists(&directory)
" }}}

" Wildmenu {{{
set wildmenu                        " Command line autocompletion
set wildmode=list:longest,full      " Shows all the options

set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.bak,*.?~,*.??~,*.???~,*.~      " Backup files
set wildignore+=*.luac                           " Lua byte code
set wildignore+=*.jar                            " java archives
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.stats                          " Pylint stats
" }}}

" Tabs, space and wrapping {{{
set expandtab                  " spaces instead of tabs
set tabstop=4                  " a tab=four spaces
set shiftwidth=4               " number of spaces for auto-indent
set softtabstop=4              " a soft-tab of four spaces
set autoindent                 " set on the auto-indent
" }}}

" Appearance {{{
set termguicolors
set background=dark

if exists('g:GuiLoaded')
    Guifont Source Code Pro for Powerline:h9
endif

" Enable true color support
if has('termguicolors')
  set termguicolors
endif

colorscheme nova
" }}}

" Fast window moves {{{
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" }}}

" Fast window & buffer close and kill {{{
nnoremap <Leader>k <C-w>c
nnoremap <silent><Leader>K :bd<CR>
" }}}

" Folding {{{
set foldmethod=marker

" Toggle folding
nnoremap \ za
vnoremap \ za
" }}}

" Cut/Paste {{{
" to/from the clipboard
map <Leader>y "+y<CR>
map <Leader>p "+p<CR>

" toggle paste mode
map <Leader>ip :set invpaste<CR>
" }}}

" Autoload configuration when this file changes ($MYVIMRC) {{{
autocmd! BufWritePost vimrc source %
" }}}

" Spelling {{{
" turn on the spell checking and set the English language
nmap <Leader>se :setlocal spell spelllang=en<CR>
" turn off the spell checking
nmap <Leader>so :setlocal nospell <CR>
" jump to the next bad spell word
nmap <Leader>sn ]s
" suggest words
nmap <Leader>sp z=
" jump to the next bad spell word and suggests a correct one
nmap <Leader>sc ]sz=
" add word to the dictionary
nmap <Leader>sa zg
" }}}

" Save as root {{{
cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>
" }}}

" Toggle the search results highlighting {{{
map <silent><Leader>eq :set invhlsearch<CR>
" }}}

" Execution permissions by default to shebang (#!) files {{{
augroup shebang_chmod
  autocmd!
  autocmd BufNewFile  * let b:brand_new_file=1
  autocmd BufWritePost * unlet! b:brand_new_file
  autocmd BufWritePre *
        \ if exists('b:brand_new_file') |
        \   if getline(1) =~ '^#!' |
        \     let b:chmod_post='+x' |
        \   endif |
        \ endif
  autocmd BufWritePost,FileWritePost *
        \ if exists('b:chmod_post') && executable('chmod') |
        \   silent! execute '!chmod '.b:chmod_post.' "<afile>"' |
        \   unlet b:chmod_post |
        \ endif
augroup END
" }}}

" }}}

" Languages {{{
autocmd BufNewFile,BufRead *.tsx set filetype=typescript
autocmd Filetype javascript,typescript,typescript.tsx setlocal ts=2 sts=2 sw=2 tw=100 cc=100
autocmd Syntax c,cpp,javascript,html,typescript,xhtml,xml normal zR
" }}}

" Plugin configuration {{{
" Airline {{{
let g:airline_powerline_fonts=1
if !exists('g:airline_symbols')
	let g:airline_symbols={}
endif
let g:airline_symbols.space="\ua0"
let g:airline#extensions#ale#enabled=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#show_buffers=0
let g:airline_theme='deus'
" }}}

" ALE {{{
let g:ale_sign_column_always=1
" }}}

" deoplete {{{
let g:deoplete#enable_at_startup=1
" Use tab to cycle forward
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" Use tab to cycle backward
inoremap <silent><expr><s-tab> pumbisible() ? "\c-p" : "\<s-tab>"
" Close the documentation window when compmletion is done
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" Remove this if you'd like to use fuzzy search
call deoplete#custom#source('dictionary', 'matchers', ['matcher_head'])
" If dictionary is already sorted, no need to sort it again.
call deoplete#custom#source('dictionary', 'sorters', [])
" Do not complete too short words
call deoplete#custom#source('dictionary', 'min_pattern_length', 3)
" }}}

" indentLine {{{
"let g:indentLine_setColors=0
" }}}

" NERDTree {{{
" Close vim when NERDTree is the only window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" toggle NERDTree
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['node_modules']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.sqp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent='<RightMouse>'
" }}}
" }}}

" Other Customizations {{{
" Set vim to save the file on focus out.
au FocusLost * :wa
" Quit window on <leader>q
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>

" Make Sure that Vim returns to the same line when we reopen a file"
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \ execute 'normal! g`"zvzz' |
        \ endif
augroup END
" }}}

" vim:foldmethod=marker
