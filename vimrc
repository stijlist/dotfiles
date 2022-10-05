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
nnoremap <leader>g :grep '\b<cword>\b'<CR>
nnoremap <leader>ev :e $MYVIMRC<CR>

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
set runtimepath+=~/.vim/vim-lsp
" blob view: <leader>gh
" blame view: <leader>gb
" repo view: <leader>go
set runtimepath+=~/.vim/vim-gh-line
if executable('rust-analyzer')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rust-analyzer',
        \ 'cmd': {server_info->['rust-analyzer']},
        \ 'whitelist': ['rust'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    let g:lsp_diagnostics_echo_cursor = 1
    let g:lsp_diagnostics_float_cursor = 1
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" Experimental language server protocol support.
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rust-analyzer'],
    \ 'go':   ['gopls'],
    \ 'zig':  ['~/zls/zig-out/bin/zls'],
    \ 'python': ['jedi-language-server']
    \ }
