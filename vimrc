call pathogen#infect()
set nocompatible
set nobackup
set noswapfile
set hidden
set splitbelow
set splitright
syntax enable
set encoding=utf-8
set laststatus=2 "ensures that vim-powerline shows up in non-split windows

" solarized and other aesthetics
call togglebg#map("<F5>")
set guioptions-=m
set number
set colorcolumn=80
highlight ColorColumn ctermbg=10
filetype plugin indent on
" for visible whitespace and its attendant settings, uncomment the following
" set listchars=tab:▸\ ,eol:¬
" sets ,l to toggle listchars on or off
" nmap <leader>l :set list!<CR>

set background=dark
colorscheme solarized 
set t_Co=256
highlight clear SignColumn
if has("mac")
	let g:solarized_termtrans=1
endif

set showcmd
set wrap
set textwidth=79
set formatoptions=qrn1

set tabstop=4 shiftwidth=4
set expandtab
set backspace=indent,eol,start " figure out how to backspace through tabs
set autoindent
" copy previous indent on enter 
set copyindent
set smartindent
set pastetoggle=<F2>

" leader-based shortcuts
let mapleader = ","
nnoremap <leader>t :CtrlP<cr> " use the command-t mapping for ctrl-p
nnoremap <leader>f :CtrlPBuffer<cr> 
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <leader><space> :noh<cr>
nnoremap <leader>a :Ack 
nnoremap / /\v
vnoremap / /\v
set gdefault
set hlsearch
set incsearch
set showmatch
set ignorecase
set smartcase

func! WordProcessorMode() 
  setlocal formatoptions=1 
  setlocal noexpandtab 
  map j gj 
  map k gk
  setlocal spell spelllang=en_us 
  set thesaurus+=/Users/sbrown/.vim/thesaurus/mthesaur.txt
  set complete+=s
  set formatprg=par
  setlocal wrap 
  setlocal linebreak 
endfu 
com! WP call WordProcessorMode()
