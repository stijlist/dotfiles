set shell=/bin/bash
set nocompatible
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-commentary'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'sjl/gundo.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'altercation/vim-colors-solarized'
" ruby
Plugin 'tpope/vim-endwise'
Plugin 'vim-ruby/vim-ruby'
" extra
Plugin 'chriskempson/base16-vim'
call vundle#end()

filetype plugin indent on
syntax enable
set nobackup
set noswapfile
" persistent undo!
set undolevels=1000
set undoreload=10000
set undodir=~/.vim/undodir
set undofile
" If a file is changed outside of vim, automatically reload it without asking
set autoread
set hidden
set splitbelow
set splitright
set showcmd
set wrap
set number
set encoding=utf-8
set wildmenu
" ensures that vim-airline shows up in non-split windows
set laststatus=2 
set tabstop=2 shiftwidth=2
set expandtab
set backspace=indent,eol,start " figure out how to backspace through tabs
set autoindent
" copy previous indent on enter 
set copyindent
set smartindent
set formatprg=par\ -w79
set pastetoggle=<F2>

set guioptions-=m
highlight ColorColumn ctermbg=10
set listchars=tab:▸\ ,eol:¬

" solarized config
set background=dark
colorscheme solarized 
call togglebg#map("<F5>")
if has("mac")
    let g:solarized_termtrans=1
endif

set t_Co=256
highlight clear SignColumn

set textwidth=79
set colorcolumn=80
set formatoptions=qrn1

" leader-based shortcuts
let mapleader = ","
nnoremap <leader>t :CtrlP<cr> " use the command-t mapping for ctrl-p
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <leader>a :!ag  
nnoremap <leader>d :!./debug.sh<cr>
nnoremap <leader>r :!./test.sh<cr>
function WriteAndRunTests()
  :w
  :!./test.sh
endfunction
nnoremap <leader>wr :call WriteAndRunTests()<cr>
nnoremap <leader>s :sp<cr>
nnoremap <leader>v :vs<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>

" improvements to search
nnoremap / /\v
vnoremap / /\v
" leader-space unhighlights searches
nnoremap <leader><space> :noh<cr>
set gdefault
set hlsearch
set incsearch
set showmatch
set ignorecase
set smartcase

autocmd FileType ruby set ts=2 sw=2
