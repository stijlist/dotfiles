set nocompatible
filetype plugin indent on
colorscheme solarized
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
set clipboard=unnamed
let mapleader=","
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>s :sp<CR>
nnoremap <leader>v :vsp<CR>
nnoremap <leader>f gqip
nnoremap <leader>r q:?^!<CR><CR>
nnoremap <leader>g :grep <cword><CR>

vnoremap s :s/\%V.*\%V.\?/\=system('surround "' . escape(input("with:"), '"`') . '"', submatch(0))/<cr>
vnoremap <leader>e :!tee .repl-pipe<CR>

set grepprg=git\ --no-pager\ grep\ --no-color\ -n\ $*
set grepformat=%f:%l:%m,%m\ %f\ match%ts,%f

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
" If a .find-filter file is present in the current directory, search the directories enumerated in it.
nnoremap <leader>t :call SelectaCommand("find $(files-to-find) -type f", "", ":e")<cr>

autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" Set the filetype based on the file's extension, but only if
" 'filetype' has not already been set
au BufRead,BufNewFile *.zig setfiletype zig

set runtimepath+=~/.vim/vim-sexp
set runtimepath+=~/.vim/vim-sexp-mappings-for-regular-people
set runtimepath+=~/.vim/LanguageClient-neovim
" blob view: <leader>gh
" blame view: <leader>gb
" repo view: <leader>go
set runtimepath+=~/.vim/vim-gh-line
" Experimental language server protocol support.
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rust-analyzer'],
    \ 'go':   ['gopls'],
    \ 'zig':  ['~/zls/zig-out/bin/zls'],
    \ 'python': ['jedi-language-server']
    \ }
autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
" nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
