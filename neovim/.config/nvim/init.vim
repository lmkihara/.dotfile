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
set relativenumber

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
    
    Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
    Plug 'preservim/nerdtree'
    Plug 'neovim/nvim-lspconfig'
    Plug 'tpope/vim-fugitive'
    Plug 'voldikss/vim-floaterm'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'morhetz/gruvbox'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'L3MON4D3/LuaSnip'
    Plug 'saadparwaiz1/cmp_luasnip'

call plug#end()

" Set colocar scheme
set background=dark
colorscheme gruvbox

" Import lua files
lua require("kihara")

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
"inoremap jj <Esc>

" fzf
nnoremap <leader>ff :Files<CR>
nnoremap <leader>gf :GFiles<CR>

" vim.fugitive
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
"augroup numbertoggle
"    autocmd!
"    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu | endif
"    autocmd BufLeave,FocusLost,InsertEnter,WinLeave * if &nu | set nornu | endif
"augroup END

" basic settings for yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab autoindent 
au BufRead,BufNewFile */ansible/*.yml set filetype=yaml.ansible
" open automatic folding
au BufRead * normal zR

" function to all yanked selection into to xclip
function! CopyXclip()
    call system('xclip -sel clipboard', @y)
endfunction
" more vimscripts here

" }}}

