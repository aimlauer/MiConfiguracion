set number
set termguicolors
set tabstop=2 shiftwidth=2 expandtab
if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif
syntax on
set relativenumber

call plug#begin('~/.vim/plugged')

Plug 'tweekmonster/gofmt.vim'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'sheerun/vim-polyglot'
Plug 'phanviet/vim-monokai-pro'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTree' }
" vim-plug
Plug 'whatyouhide/vim-gotham'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'gruvbox-community/gruvbox'

call plug#end()

colorscheme gotham
