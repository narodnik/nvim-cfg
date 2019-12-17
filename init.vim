execute pathogen#infect()
syntax on

" size of hard tabs
set ts=4
" size of soft tabs
set sw=4
" use soft tabs
set et
" treat X spaces like a tab
set sts=4

"map <buffer> <S-e> :w<CR>:!/usr/bin/env python % <CR>
set cursorline
hi CursorLine   cterm=NONE ctermbg=darkgrey
hi Folded ctermbg=NONE
set hlsearch

"map ; :
nnoremap <Space> :
vnoremap <Space> :
" when moving up or down, don't move cursor left or right
set nostartofline

" tab to jump between brackets and braces
nnoremap <tab> %
vnoremap <tab> %

" cursor can go anywhere on screen :)
set virtualedit=all
set ruler
set splitright
set splitbelow
" persistant undo
set undofile
set undodir=/tmp
set relativenumber
set numberwidth=3
" turn on default indent for filetype
filetype indent on
" enable mouse for resizing splits
set mouse=a
"set ttymouse=xterm2

map <C-J> <C-w>j
map <C-K> <C-w>k
map <C-H> <C-w>h
map <C-L> <C-w>l

vmap > >gv
vmap < <gv
" quick recording type qq, then Q to do it
nnoremap Q @q

" remove annoying help
map <f1> <nop>

" make highlighted searches disappear
nmap <C-N> :noh <CR>

" disable bad habit
inoremap <DOWN> <nop>
inoremap <UP> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
" scroll buffer without moving cursor
nnoremap <DOWN> <C-E>
nnoremap <UP> <C-Y>
nnoremap <left> <nop>
nnoremap <right> <nop>

" peek up/down
map <pageup> zb5<c-e>
map <pagedown> zt5<c-y>
map <end> zz

" 80 chars max
set tw=80
set cc=+1
hi ColorColumn ctermbg=black
imap <f1> <nop>

" completion to be like bash
set wildmode=list:longest

" use arrow keys to switch buffers
map <right> gt
map <left> gT
" speed up esc
set ttimeoutlen=50

" jump to end and start of lines shortcuts
no 0 ^
no - $

" set my leader to backspace
let mapleader="\<bs>"
" set backspace, a to open lustyjuggler
map <leader>a :LustyJuggler<cr>
" shut up LustyExplorer!
set hidden

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

tnoremap <esc> <C-\><C-n>

" live preview of substitutions
set icm=nosplit

" open files relative to current buffer
set autochdir

" show files in normal style like file browser
let g:netrw_liststyle = 2
" no banner for file browser!
let g:netrw_banner = 0
" hide dot files
let ghregex='\(^\|\s\s\)\zs\.\S\+'
let g:netrw_list_hide=ghregex

