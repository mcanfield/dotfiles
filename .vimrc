set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Plugin bundles
Bundle 'altercation/vim-colors-solarized'
Bundle 'groenewege/vim-less'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'http://github.com/mileszs/ack.vim.git'

syntax enable
set background=dark
colorscheme solarized
filetype plugin indent on

set foldmethod=manual
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set wildmenu
set hidden
set number

autocmd FileType html setlocal shiftwidth=2 tabstop=2 expandtab
