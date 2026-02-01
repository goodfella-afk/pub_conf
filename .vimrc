" :set paste / :set nopaste

" Prereqs
set nocompatible
filetype plugin indent on
syntax on

"vim-plug plugin manager - keep em minimal
call plug#begin()
Plug 'vimwiki/vimwiki'
Plug 'preservim/nerdtree'
call plug#end()

" -------------------------------- Remaps BEGIN
let mapleader = " "

"VimWiki
let g:vimwiki_list = [{'path': '$HOME/Documents/notes','syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_listsyms = '✗○◐●✓'

"xsel copy to yank register and to system clipboard
xnoremap <leader>y y:call system('xsel -ib', @")<CR>

"Toggle relativenumbers (for tmux yank)
nnoremap <leader>N :set relativenumber!<CR>

"CTRL+W+N = normal mode in term
set termwinsize=0x62
nnoremap <leader>ot :rightbelow vertical term<CR>

"NerdTree and vanilla find/navigation
nnoremap <leader><BACKSPACE> :NERDTreeFocus<CR>
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>/ :find<Space>
nnoremap <leader>q :bw<CR>
nnoremap <leader>l :ls<CR>:b<Space>
nnoremap <leader>j :bnext<CR>
nnoremap <leader>k :bprev<CR>

"netrw
nnoremap <leader>pv :Ex<CR>
let g:netrw_banner=0
let g:netrw_liststyle=3

"Timestamp
nnoremap <leader>t i<C-R>=strftime("%d-%B-%Y-%H:%M")<CR><Esc>

"J,K in visual mode will move selection up or down.
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Moving lines upwards with J, will preserve cursor at the beggining of line
nnoremap J mzJ`z

" Stay in middle of screen while searching
nnoremap n nzzzv
nnoremap N Nzzzv

" Q sucks
nnoremap Q <nop>

" Find and replace on word
nnoremap <leader>S :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" chmod
nnoremap <leader>x <cmd>!chmod +x %<CR>

" Don't cross 80chars
nnoremap <leader>b :execute "set colorcolumn=" . (&colorcolumn == "" ? "80" : "")<CR>

" LineWrap toggle
nnoremap <leader>W :set wrap!<CR>
" -------------------------------- Remaps END

" ------ Settings

set relativenumber

"Indent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

set smartindent

set nohlsearch
set incsearch
set termguicolors

set scrolloff=8
set updatetime=50

set background=dark
highlight Visual guibg=Gray20

set path+=**
set wildmenu wildoptions=pum
set wildignore+=**/node_modules/**,**/dist/**,**/__pycache__/**
set ignorecase
set title
set showcmd

" Man pages - :Man [n] <dest>
" We can [count]+K on word inside - goto man(1-x) in current buffer
runtime! ftplugin/man.vim
