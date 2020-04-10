set nocompatible
set encoding=utf-8

" vim plugins, managed by Plug
filetype off
call plug#begin('~/.vim/plugged')

Plug 'dyng/ctrlsf.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'flazz/vim-colorschemes'
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'justinmk/vim-gtfo'
Plug 'justinmk/vim-sneak'
Plug 'kien/rainbow_parentheses.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pbrisbin/vim-colors-off'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'suan/vim-instant-markdown'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/gitignore'
Plug 'vim-scripts/visincr'
Plug 'xuyuanp/nerdtree-git-plugin'

call plug#end()
filetype plugin indent on
syntax enable

" main settings
set autoindent
set autoread
set autowrite
set backspace=2
set complete=.,b,u,]
set completeopt=longest,menu
set directory=/tmp
set expandtab
set fillchars+=vert:│
set foldmethod=manual
set formatoptions+=j
set hidden
set history=10000
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set list
set listchars=""
set listchars+=extends:❯
set listchars+=nbsp:⋅
set listchars+=precedes:❮
set listchars+=trail:⋅
set listchars+=tab:▸\
set magic
set nobackup
set nofoldenable
set nojoinspaces
set nowrap
set nowritebackup
set numberwidth=2
set pumheight=10
set relativenumber
set ruler
set scrolloff=10
set shiftwidth=4
set shortmess+=cI
set showcmd
set signcolumn=yes
set smartcase
set softtabstop=4
set t_ti= t_te=
set tabstop=4
set tags=./.tags,.tags,./tags,tags;/
set textwidth=79
set timeoutlen=500
set title
set titleold=""
set titlestring="vim: %F"
set undodir=~/.vim/undo
set undofile
set undolevels=100
set undoreload=10000
set updatetime=300
set virtualedit=block
set wildmode=longest,list

let &showbreak = '↳ '

" colorscheme
if $TERM =~ "-256color"
    set t_ut= t_Co=256
    let g:hybrid_use_Xresources = 1
endif

set background=dark
colorscheme hybrid
highlight clear conceal

" vimdiff
if &diff
    set diffopt=filler
endif

" restore cursor position when reopening a file
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" check external modifications when inactive
autocmd CursorHold * checktime

" functions
function! ToggleColors()
    if g:colors_name == 'hybrid'
        set background=dark
        colorscheme off
        AirlineTheme zenburn
        highlight clear conceal
    elseif g:colors_name == 'off'
        set background=light
        colorscheme hybrid-light
        AirlineTheme hybrid
        highlight clear conceal
    else
        set background=dark
        colorscheme hybrid
        AirlineTheme hybrid
        highlight clear conceal
    endif
endfunction

function! ToggleNumbers()
    if (&relativenumber == 1)
        set norelativenumber
        set number
    else
        set nonumber
        set relativenumber
    endif
endfunction

function! ToggleConceal()
    if &conceallevel >= 1
        set conceallevel=0 concealcursor=
    else
        set conceallevel=1 concealcursor=
    endif
endfunction

function! KillWhitespace()
    let l:cursor_position = getpos('.')
    %s/\s\+$//ge
    call setpos('.', l:cursor_position)
endfun

" mappings
let mapleader=","
let maplocalleader=";"
noremap ,, ,

nnoremap q: <Nop>
nnoremap q/ <Nop>
nnoremap q? <Nop>

" navigation between split windows with Ctrl+[hjkl]
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" open split windows in places with leader+[HJKL]
nnoremap <silent><leader>H :leftabove vnew<cr>
nnoremap <silent><leader>L :rightbelow vnew<cr>
nnoremap <silent><leader>K :leftabove new<cr>
nnoremap <silent><leader>J :rightbelow new<cr>

" navigation between buffers (Tab and Shift+Tab)
nnoremap <silent><tab> :bnext<cr>
nnoremap <silent><s-tab> :bprevious<cr>

" disable cursor keys in normal mode
nnoremap <Left>  <nop>
nnoremap <Right> <nop>
nnoremap <Up>    <nop>
nnoremap <Down>  <nop>

" simple delimitmate
inoremap {<cr> {<cr>}<c-o>O
inoremap [<cr> [<cr>]<c-o>O
inoremap (<cr> (<cr>)<c-o>O
inoremap {<Space> { }<Left>
inoremap [<Space> [ ]<Left>
inoremap (<Space> ( )<Left>

noremap <leader>m :make<cr>
noremap <silent><leader>r :redraw!<cr>
noremap <silent><leader>k :call KillWhitespace()<cr>

noremap <f5> :call ToggleColors()<cr>
noremap <f6> :call ToggleNumbers()<cr>
noremap <f7> :call ToggleConceal()<cr>
noremap <f8> :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<cr>

cnoremap %% <c-r>=expand('%:p:h').'/'<cr>

nnoremap <silent><cr> :nohlsearch<cr>
nnoremap <silent><leader>D "=strftime("%Y/%m/%d %H:%M")<cr>p
nnoremap <silent><leader>b <c-^>
nnoremap Q <nop>


" plugin settings

" Airline
let g:airline_powerline_fonts               = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#tabline#enabled    = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Conquer of Completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <c-space> coc#refresh()

nmap <leader>ac <Plug>(coc-codeaction)
nmap <leader>rn <Plug>(coc-rename)
nmap <silent>[c <Plug>(coc-diagnostic-prev)
nmap <silent>]c <Plug>(coc-diagnostic-next)
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gi <Plug>(coc-implementation)
nmap <silent>gr <Plug>(coc-references)
nmap <silent>gy <Plug>(coc-type-definition)

nnoremap <silent><space>a :<C-u>CocList diagnostics<cr>
nnoremap <silent><space>o :<C-u>CocList outline<cr>
nnoremap <silent><space>s :<C-u>CocList -I symbols<cr>
nnoremap <silent><space>j :<C-u>CocNext<CR>
nnoremap <silent><space>k :<C-u>CocPrev<CR>
nnoremap <silent><space>p :<C-u>CocListResume<CR>

nnoremap <silent> F :call CocAction('format')<CR>
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

" CtrlSF
nmap <leader>s <Plug>CtrlSFCwordPath<CR>

" EasyAlign
vmap <Enter>   <Plug>(LiveEasyAlign)
nmap <leader>a <Plug>(LiveEasyAlign)

" FZF
nnoremap <leader>p :FZF<cr>
nnoremap <c-p> :GFiles --cached --others --exclude-standard<cr>

" GTFO
let g:gtfo#terminals = { 'unix': 'urxvtc -cd' }

" Multiple Cursors
let g:multi_cursor_select_all_word_key = 'n'

" NerdCommenter
let g:NERDCreateDefaultMappings    = 1
let g:NERDCommentWholeLinesInVMode = 1
let g:NERDSpaceDelims              = 1

" NerdTree
let g:NERDTreeMinimalUI  = 0
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeShowHidden = 1

function! ToggleFindNERD()
    if exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
        exec ':NERDTreeToggle'
    else
        exec ':NERDTreeFind'
    endif
endfunction

noremap <silent><leader>f :call ToggleFindNERD()<cr>

" RipGrep
let g:rg_command = 'rg --vimgrep --smart-case'
