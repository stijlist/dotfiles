set nocompatible
filetype plugin indent on
set hidden
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set shell=/bin/bash
set t_ti= t_te=
set scrolloff=3
set nobackup
set nowritebackup
set noswapfile
set backspace=indent,eol,start
set showcmd
set wildmode=longest,list
set wildmenu
set autoindent
set timeout timeoutlen=1000 ttimeoutlen=100
set autoread
set incsearch
set ignorecase
set smartcase
let mapleader=","
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>s :sp<CR>
nnoremap <leader>v :vsp<CR>
nnoremap <leader>a :Search 
nnoremap <leader>c :!git ca<CR>
nnoremap <leader>f gqip
nnoremap <leader>r q:?^!<CR><CR>

vnoremap s :s/\%V.*\%V.\?/\=system('surround "' . escape(input("with:"), '"`') . '"', submatch(0))/<cr>

" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaCommand(choice_command, selecta_args, vim_command)
  try
    let selection = system(a:choice_command . " | selecta " . a:selecta_args)
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction

" Find all files in all non-dot directories starting in the working directory.
" Fuzzy select one of those. Open the selected file with :e.
nnoremap <leader>t :call SelectaCommand("find * -type f", "", ":e")<cr>
command! Jade !jade %
command! -nargs=1 Search !rg <args>
" TODO: we can probably get identifier-based autocompletion here

