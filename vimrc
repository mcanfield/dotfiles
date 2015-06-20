set nocompatible
filetype on " without this vim emits a zero exit status because of :ft off
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/vundle'

" Plugin bundles
Plugin 'altercation/vim-colors-solarized'
Plugin 'groenewege/vim-less'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'rking/ag.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-obsession'
Plugin 'airblade/vim-gitgutter'
Plugin 'marijnh/tern_for_vim'
Plugin 'jiangmiao/auto-pairs'

call vundle#end()

syntax enable
colorscheme solarized
set background=dark
filetype plugin indent on

set autoindent
set autoread                          " reload files when changed on disk, i.e. via `git checkout`
set backspace=2                       " Fix broken backspace in some setups
set backupcopy=yes                    " see :help crontab
set clipboard=unnamed                 " yank and paste with the system clipboard
set directory-=.                      " don't store swapfiles in the current directory
set encoding=utf-8
set expandtab                         " expand tabs to spaces
set fileformats=unix,dos
set fileformat=unix
set foldmethod=manual
set hidden
set hlsearch
set ignorecase                        " case-insensitive search
set incsearch                         " search as you type
set laststatus=2                      " always show statusline
set list                              " show trailing whitespace
set listchars=tab:▸\ ,trail:▫
set number                            " show line numbers
set ruler                             " show where you are
set scrolloff=3                       " show context above/below cursorline
set shiftwidth=4                      " normal mode indentation commands use 4 spaces
set showcmd
set smartcase                         " case-sensitive search if any caps
set softtabstop=4                     " insert mode tab and backspace use 4 spaces
set smartindent
set tabstop=4                         " actual tabs occupy 4 characters
set wildignore=log/**,node_modules/**,target/**,tmp/**
set wildmenu                          " show a navigable menu for tab completion
set wildmode=longest,list,full


" Keybindings
let mapleader = ','
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
nmap <leader>a :Ag<space>
nmap <leader>b :CtrlPBuffer<CR>
nmap <leader>t :CtrlP<CR>
nmap <leader>T :CtrlPClearCache<CR>:CtrlP<CR><CR>
nmap <leader>$ :call Preserve("%s/\\s\\+$//e")<CR>
nmap <leader>= :call Preserve("normal gg=G")<CR>
nmap <leader>g :GitGutterToggle<CR>
nmap <leader>P :put!<CR>
nmap <leader>p :put<CR>
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" plugin settings
let g:ctrlp_match_window='order:ttb,max:20'
"let g:gitgutter_enabled=0
let g:tern_map_keys=1
let g:tern_show_argument_hint='on_hold'

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
    " Use Ag over Grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Add an .agignore file to hide
    " unwanted search results.
    let g:ctrlp_user_command = 'ag %s -l -f --nocolor --hidden -g ""'
endif

" Use <leader>l to clear the highlighting of :set hlsearch.
if maparg('<leader>l', 'n') ==# ''
    nnoremap <silent> <leader>l :nohlsearch<CR><leader>l
endif

function! Preserve(command)
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    execute a:command
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

function! Incr()
    let a = line('.') - line("'<")
    let c = virtcol("'<")
    if a > 0
        execute 'normal! '.c.'|'.a."\<C-a>"
    endif
    normal `<
endfunction

vnoremap <leader>n :call Incr()<CR>

au FileType html setlocal shiftwidth=2 tabstop=2 expandtab
au BufRead,BufNewFile *.jsp set filetype=html
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile .bash_aliases set filetype=sh

if filereadable(expand("~/.vimrc.local"))
    " In your .vimrc.local, you might like:
    "
    " set autowrite
    " set nocursorline
    " set nowritebackup
    " set whichwrap+=<,>,h,l,[,] " Wrap arrow keys between lines
    "
    " autocmd! bufwritepost .vimrc source ~/.vimrc
    " noremap! jj <ESC>
    source ~/.vimrc.local
endif
