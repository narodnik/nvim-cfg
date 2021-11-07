call plug#begin('~/.config/nvim/plugged')

"execute pathogen#infect()
Plug 'junegunn/vim-easy-align'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'wellle/targets.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'Tumbler/highlightMarks'
Plug 'machakann/vim-swap'
Plug 'petRUShka/vim-sage'
Plug 'jbyuki/instant.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'narodnik/NeoSolarized'

call plug#end()

set background=dark
colorscheme NeoSolarized
let g:neosolarized_termtrans = 1

let g:instant_username = "narodnik"

" bookmarks color
let g:highlightMarks_colors = ['#422943']

highlight IndentBlanklineChar guifg=#222222 gui=nocombine
hi CocHintSign guifg=#383838

syntax on

" size of hard tabs
set ts=4
" size of soft tabs
set sw=4
" use soft tabs
set et
" treat X spaces like a tab
set sts=4

" 24 bit colors
set tgc

"map <buffer> <S-e> :w<CR>:!/usr/bin/env python % <CR>
set cursorline
hi CursorLine   cterm=NONE guibg=#222526
hi Folded guibg=NONE
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
" persistant undo
set undofile
set undodir=/tmp
set numberwidth=3
" turn on default indent for filetype
filetype indent on
" enable mouse for resizing splits
set mouse=a
"set ttymouse=xterm2

set relativenumber
" but also show current lineno
set number

map <C-J> <C-w>j
map <C-K> <C-w>k
map <C-H> <C-w>h
map <C-L> <C-w>l

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
autocmd FileType text setlocal tw=0
autocmd FileType markdown setlocal tw=0
autocmd FileType rst setlocal tw=0
set cc=+1
hi ColorColumn guibg=black
imap <f1> <nop>

" completion to be like bash
set wildmode=list:longest

" use arrow keys to switch buffers
map <right> :tabn<cr>
map <left> :tabp<cr>
" speed up esc
set ttimeoutlen=50

" jump to end and start of lines shortcuts
no 0 ^
no - $

" set my leader to backspace
let mapleader="\<bs>"

" fzf commands
nmap <Leader>f :GFiles<CR>
nmap <Leader>F :Files<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>h :History<CR>
nmap <Leader>t :BTags<CR>
nmap <Leader>T :Tags<CR>
nmap <Leader>l :BLines<CR>
nmap <Leader>L :Lines<CR>
nmap <Leader>' :Marks<CR>

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

" use escape in the terminal
au! TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
au! FileType fzf tunmap <buffer> <Esc>
" when opening new terminal, auto enter insert mode
autocmd TermOpen * startinsert
" when switching to terminal, automatically enter insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" map keys to switch out of terminal
tnoremap <C-J> <C-\><C-n><C-w>j
tnoremap <C-K> <C-\><C-n><C-w>k
tnoremap <C-H> <C-\><C-n><C-w>h
tnoremap <C-L> <C-\><C-n><C-w>l

" jump to definitions with coc
" see also :h coc-action-jumpDefinition
nmap <silent> gc :call CocAction('jumpDefinition')<CR>zt
nmap <silent> gs :call CocAction('jumpDefinition', 'split')<CR>zt
nmap <silent> gv :call CocAction('jumpDefinition', 'vsplit')<CR>zt
nmap <silent> gt :call CocAction('jumpDefinition', 'tabe')<CR>zt
nmap go <c-o>zz

" live preview of substitutions
set icm=nosplit

" open files relative to current buffer
"set autochdir

" show files in normal style like file browser
let g:netrw_liststyle = 2
" no banner for file browser!
let g:netrw_banner = 0
" hide dot files
let ghregex='\(^\|\s\s\)\zs\.\S\+'
let g:netrw_list_hide=ghregex

" reload my marks when i load a new file
let g:mwAutoLoadMarks=1

function! MakeRustFuncDefs()
    let b:RustFuncDefs = []

    let lnum = 1
    while lnum <= line('$')
        let current_line = getline(lnum)
        if match(current_line, '^ *\(pub \)\?fn') > -1
            call AddRustFunc(lnum)
        endif

        let lnum += 1
    endwhile
endfunction

function! AddRustFunc(lnum)
    let save_pos = getpos('.')
    call setpos('.', [0, a:lnum, 1, 0])

    call search('{')
    let start_lnum = line('.')

    let end_lnum = searchpair('{', '', '}', 'n')
    if end_lnum < 1
        call setpos('.', save_pos)
        return
    endif

    call add(b:RustFuncDefs, [start_lnum, end_lnum]);
    call setpos('.', save_pos)
endfunction

function! RustFold()
    if !exists("b:RustFuncDefs")
        call MakeRustFuncDefs()
    endif

    for [start_lnum, end_lnum] in b:RustFuncDefs
        if start_lnum > v:lnum
            return 0
        endif

        if v:lnum == start_lnum + 1
            return ">1"
        elseif v:lnum == end_lnum
            return "<1"
        elseif v:lnum > start_lnum && v:lnum < end_lnum
            return "="
        endif
    endfor
endfunction

function! ReloadRustFolds()
    unlet b:RustFuncDefs
    normal zx
endfunction

"autocmd FileType rust setlocal foldmethod=expr foldexpr=RustFold()
"nnoremap <leader>e :call ReloadRustFolds()<cr>

"au BufWritePost *.rs silent! execute "!cargo fmt" | redraw! | edit

autocmd BufRead *.pism call SetPismOptions()
autocmd BufRead *.psm call SetPismOptions()
function SetPismOptions()
    set syntax=pism
    source /home/narodnik/src/sapvi/scripts/pism.vim
endfunction

" disable annoying grey column on left opened by CoC
set signcolumn=no

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" remember cursor position
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

