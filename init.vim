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
set relativenumber
syntax on


call plug#begin('~/.vim/plugged')

Plug 'tweekmonster/gofmt.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTree' }

 Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
 Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'gruvbox-community/gruvbox'

call plug#end()


colorscheme gruvbox
