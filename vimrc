execute pathogen#infect()
set nocompatible
syntax enable
filetype plugin indent on
set nobackup
set noswapfile
set hidden
set splitbelow
set splitright
set showcmd
set wrap
set number
set encoding=utf-8
" ensures that vim-airline shows up in non-split windows
set laststatus=2 
set tabstop=4 shiftwidth=4
set expandtab
set backspace=indent,eol,start " figure out how to backspace through tabs
set autoindent
" copy previous indent on enter 
set copyindent
set smartindent
set pastetoggle=<F2>

set guioptions-=m
highlight ColorColumn ctermbg=10
set listchars=tab:▸\ ,eol:¬

" solarized config
" set background=dark
" colorscheme solarized 
" call togglebg#map("<F5>")
" if has("mac")
	" let g:solarized_termtrans=1
" endif
" set t_Co=256
" highlight clear SignColumn

set textwidth=79
set colorcolumn=80
set formatoptions=qrn1

" leader-based shortcuts
let mapleader = ","
nnoremap <leader>t :CtrlP<cr> " use the command-t mapping for ctrl-p
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <leader>a :Ack 

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

" conveniences for prose editing
func! WordProcessorMode() 
  setlocal formatoptions=1 
  setlocal noexpandtab 
  map j gj 
  map k gk
  setlocal spell spelllang=en_us 
  " set thesaurus+=/Users/sbrown/.vim/thesaurus/mthesaur.txt
  set complete+=s
  set formatprg=par
  setlocal wrap 
  setlocal linebreak 
endfu 
com! WP call WordProcessorMode()
