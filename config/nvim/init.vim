" General Settings
"

set expandtab
set shiftwidth=4
set tabstop=4
set autoindent
set hidden
set signcolumn=yes:2
set relativenumber
set number
"set termguicolors
set wildmode=longest:full,full
set nowrap
set undofile

set showmatch               " show matching
set ignorecase              " case insensitive
set hlsearch                " highlight search
set incsearch               " incremental search
set cursorline              " highlight current cursor line

set smartcase
set title
set spell

set list
set listchars=tab:🢒\ ,trail:·
set scrolloff=8
set sidescrolloff=8
set nojoinspaces
set clipboard=unnamedplus

""""""""""""""""""""""
" Key maps
""""""""""""""""""""""


let mapleader = "\<space>"

nmap <leader>ve :edit ~/.config/nvim/init.vim<cr>
nmap <leader>vc :edit ~/.config/nvim/coc-settings.json<cr>
nmap <leader>vr :source ~/.config/nvim/init.vim<cr>

map gf :edit <cfile><cr>            " Open file even if it does not exist

" Reselect visual selection after indenting
vnoremap < <gv
vnoremap > >gv


" Open the current file in the default program
nmap <leader>x :!xdg-open %<cr><cr>



"""""""""""""""""""""
" Plugins
"""""""""""""""""""""

" Automatically install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin(data_dir . '/plugins')
 Plug 'dracula/vim'
 Plug 'ryanoasis/vim-devicons'
 Plug 'SirVer/ultisnips'
 Plug 'tpope/vim-fugitive'
 Plug 'honza/vim-snippets'
 Plug 'preservim/nerdtree'
 Plug 'preservim/nerdcommenter'
 Plug 'mhinz/vim-startify'
 Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()






