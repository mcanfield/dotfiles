set nocompatible
filetype on " without this vim emits a zero exit status because of :ft off
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" Plugin bundles
Bundle 'altercation/vim-colors-solarized'
Bundle 'groenewege/vim-less'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'rking/ag.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-commentary'
Bundle 'airblade/vim-gitgutter'

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
nmap <leader>a :Ag
nmap <leader>b :CtrlPBuffer<CR>
nmap <leader>t :CtrlP<CR>
nmap <leader>T :CtrlPClearCache<CR>:CtrlP<CR><CR>
nmap <leader>$ :call Preserve("%s/\\s\\+$//e")<CR>
nmap <leader>= :call Preserve("normal gg=G")<CR>
nmap <leader>g :GitGutterToggle<CR>
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" plugin settings
let g:ctrlp_match_window = 'order:ttb,max:20'
"let g:gitgutter_enabled = 0

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

autocmd FileType html setlocal shiftwidth=2 tabstop=2 expandtab
autocmd BufRead,BufNewFile *.md set filetype=markdown

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
