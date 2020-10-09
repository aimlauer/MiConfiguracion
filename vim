cit
dt<
Siempre uso vim-plug pero debería probar vundle.
actual theme: orbital (https://github.com/fcpg/vim-orbital)

actual .vimrc:

syntax on
set number
"let g:gruvbox_termcolors=256
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
set background=dark

call plug#begin('~/.vim/plugged')

Plug 'tweekmonster/gofmt.vim'
Plug 'fcpg/vim-orbital'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'tpope/vim-fugitive'
"Plug 'vim-utils/vim-man'
"Plug 'sheerun/vim-polyglot'
Plug 'phanviet/vim-monokai-pro'
" vim-plug
"Plug 'vim-airline/vim-airline'
Plug 'gruvbox-community/gruvbox'

call plug#end()

colorscheme orbital
