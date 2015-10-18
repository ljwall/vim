runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

syntax on
set number
set nowrap

if has('gui_running')
    set background=dark
    colorscheme solarized
endif

vnoremap . :norm.<CR>

set softtabstop=4 shiftwidth=4 expandtab
set scrolloff=3

autocmd FileType html setlocal softtabstop=2 shiftwidth=2 expandtab
autocmd FileType javascript setlocal softtabstop=2 shiftwidth=2 expandtab


let g:neocomplete#enable_at_startup = 1

if has("gui_macvim")
    set guifont=Courier\ New:h14
endif

set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

filetype plugin indent on
set encoding=utf-8


map <C-\> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

highlight ShowTrailingWhitespace ctermbg=Red guibg=Red

