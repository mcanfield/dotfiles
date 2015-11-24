set nocompatible
filetype on " without this vim emits a zero exit status because of :ft off
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle - required!
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
Plugin 'henrik/vim-indexed-search'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'scrooloose/syntastic'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'othree/javascript-libraries-syntax.vim'
"Plugin 'Shougo/unite.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'MarcWeber/vim-addon-local-vimrc'
Plugin 'burnettk/vim-angular'
Plugin 'SirVer/ultisnips'
Plugin 'matthewsimo/angular-vim-snippets'
Plugin 'honza/vim-snippets'
Plugin 'mcanfield/snippets'
Plugin 'mattn/emmet-vim'
Plugin 'einars/js-beautify'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'mtth/scratch.vim'

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
set shiftwidth=2                      " normal mode indentation commands use 2 spaces
set showcmd
set smartcase                         " case-sensitive search if any caps
set softtabstop=2                     " insert mode tab and backspace use 2 spaces
set smartindent
set tabstop=2                         " actual tabs occupy 2 characters
set wildignore=log/**,node_modules/**,target/**,tmp/**
set wildmenu                          " show a navigable menu for tab completion
set wildmode=longest,list,full


" Keybindings
let mapleader = ','
let maplocalleader = ' '
inoremap jj <ESC>
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
noremap <silent> <F4> :let @+=expand("%")<CR>
nnoremap <silent> <leader>l :nohlsearch<CR>:echo ''<CR>
vnoremap <leader>n :call Incr()<CR>
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" Plugin Settings

let g:ctrlp_match_window='order:ttb,max:20'
"let g:gitgutter_enabled=0

" Multiple cursors
let g:multi_cursor_start_key='<leader>m'
let g:multi_cursor_insert_maps={'j':1}

" Tern.js
let g:tern_map_keys=1
let g:tern_show_argument_hint='on_hold'

" vim-indexed-search
let g:indexed_search_dont_move=1
let g:indexed_search_numbered_only=1
let g:indexed_search_shortmess=1

" YouCompleteMe
let g:ycm_key_list_select_completion=['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion=['<C-p>', '<Up>']
let g:ycm_autoclose_preview_window_after_insertion=1

" vim-angular
let g:angular_filename_convention='titlecased'

" UltiSnips
let g:UltiSnipsExpandTrigger='<Tab>'
let g:UltiSnipsJumpForwardTrigger='<Tab>'
let g:UltiSnipsJumpBackwardTrigger='<S-Tab>'

" javascript-libraries-syntax
let g:used_javascript_libs = 'underscore,backbone,angularjs,angularui,angularuirouter,requirejs,jasmine'
" /Plugin Settings

" autocommands
au FileType html setlocal shiftwidth=2 tabstop=2 expandtab
au BufRead,BufNewFile *.jsp set filetype=html
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile .bash_aliases set filetype=sh

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
    " Use Ag over Grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Add an .agignore file to hide
    " unwanted search results.
    let g:ctrlp_user_command = 'ag %s -l -f --nocolor --hidden -g ""'
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
