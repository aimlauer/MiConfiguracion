autocmd BufWritePost resume_spanish.tex !pdflatex /home/hizmy/hizmy/MiCV/pro/resume_spanish.tex
autocmd BufWritePost resume_english.tex !pdflatex /home/hizmy/hizmy/MiCV/pro/resume_english.tex

set termguicolors
"let g:carbonized_dark_LineNr = 'off'
"let g:carbonized_light_LineNr = 'off'


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

"Plug 'tweekmonster/gofmt.vim'
"Plug 'fcpg/vim-orbital'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'tpope/vim-fugitive'
"Plug 'vim-utils/vim-man'
"Plug 'sheerun/vim-polyglot'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'phanviet/vim-monokai-pro'
Plug 'owickstrom/vim-colors-paramount'
" vim-plug
Plug 'gruvbox-community/gruvbox'
Plug 'nightsense/carbonized'
Plug 'ajmwagar/vim-deus'
Plug 'Badacadabra/vim-archery'
Plug 'cseelus/vim-colors-lucid'

call plug#end()

"colorscheme gruvbox
"colorscheme orbital
"colorscheme onehalfdark
"colorscheme archery
colorscheme lucid 
