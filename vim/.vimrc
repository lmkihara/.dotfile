" PERSONAL CONFIGURATION
" Disable vi compatibility
set nocompatible
" Enable type file detection, plugins and indent
filetype on
filetype plugin on
filetype indent on
" Turn on syntax highlighting and cursor positision vert and horiz
set cursorline
set cursorcolumn
syntax on
let python_highlight_all=1
set number

" Set shift width to 4 spaces
set shiftwidth=4
" Set tab width to 4 columns
set tabstop=4
" Use space characters instead of tabs
set expandtab
" Do not save bkp file
set nobackup
" Do not let cursor scroll below or above N number of lines when scrolling
set scrolloff=20
" Do not wrap lines. Allow long lines to extend as far as the line goes
set nowrap
" Incrementally highlight matching characters
set incsearch
" Ignor capital case
set ignorecase
set smartcase
"Show partial command in the last line of the screen
set showmode
" Show matching words in a search
set showmatch
set hlsearch
" Set the commands to save in history
set history=1000

" Enable auto completion menu after pressing TAB
set wildmenu
" Make wildmenu behave like similar to Bash completion
set wildmode=list:longest

" Wildmenu ignores extension files
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Set colocar scheme
set background=dark
colorscheme gruvbox

" Set configuration vim-floaterm
let g:floaterm_wintype='float'
let g:floaterm_width=0.9
let g:floaterm_height=0.9

" Default fzf layout
" - Popup window (center of the screen)
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" PLUGINS ------------------------------------------------------------------ {{{

" plugin code goes here.
call plug#begin('~/.vim/plugged')
    
    Plug 'preservim/nerdtree'
    Plug 'prabirshrestha/vim-lsp'
"    Plug 'dense-analysis/ale'
    Plug 'hashivim/vim-terraform'
    Plug 'tpope/vim-fugitive'
    Plug 'voldikss/vim-floaterm'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
"    Plug 'altercation/vim-colors-solarized'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-syntastic/syntastic'
    Plug 'nvie/vim-flake8'

call plug#end()

" Configuration vim-terraform
let g:terraform_align=1
let g:terraform_fold_sections=1
let g:terraform_fmt_on_save=1

" }}}

" MAPPINGS ----------------------------------------------------------------- {{{

" mapping code goes here.
" Leader
"map <C-k> <leader>
let mapleader = " "

" floaterm mapping
let g:floaterm_keymap_new = '<F7>'
let g:floaterm_keymap_toggle = '<F12>'

" type jj to exit insert mode quickly
inoremap jj <Esc>

" fzf
nnoremap <leader>ff :Files<CR>
nnoremap <leader>gf :GFiles<CR>

" vim.figitive
nnoremap <leader>gs :G<CR>

" xclip copy
vnoremap <leader>y "yy <Bar> :call CopyXclip()<CR>

" nerdtree
nnoremap <leader>nn :NERDTree<CR>
nnoremap <leader>nc :NERDTreeClose<CR>
" }}}

" VIMSCRIPT ---------------------------------------------------------------- {{{

" this enable code folding
" use the maker method of folding
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" switch line number mode
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave * if &nu | set nornu | endif
augroup END

" basic settings for yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab autoindent 

" open automatic folding
au BufRead * normal zR

" function to all yanked selection into to xclip
function! CopyXclip()
    call system('xclip -sel clipboard', @y)
endfunction
" more vimscripts here

" }}}

" STATUS LINE -------------------------------------------------------------- {{{

" status bar code here
" clear status line when vimrc is reloaded
set statusline=

" Status line left side
set statusline+=\ %F\ %M\ %Y\ %R\ %{FugitiveStatusline()}

" Use a divider to separate the left side from the right side
set statusline+=%=

" Status line right side
set statusline+=\ row:\ %l\ col:\ %c\ percent:\ %p%%

" Show the status on the econd to last line
set laststatus=2

" }}}
"
" LSP CONFIGURATION -------------------------------------------------------- {{{
"
" bash-language-server
if executable('bash-language-server')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'bash-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'bash-language-server start']},
        \ 'allowlist': ['sh'],
        \ })
endif

" configuration vim-lsp
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> vd <plug>(lsp-definition)
    nmap <buffer> vs <plug>(lsp-document-symbol-search)
    nmap <buffer> vS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> vr <plug>(lsp-references)
    nmap <buffer> vi <plug>(lsp-implementation)
    nmap <buffer> vt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> vg <plug>(lsp-previous-diagnostic)
    nmap <buffer> vg <plug>(lsp-next-diagnostic)
    nmap <buffer> vK <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
        
