runtime bundle/vim-pathogen/autoload/pathogen.vim


syntax on

vnoremap . :norm.<CR>

:set softtabstop=4 shiftwidth=4 expandtab

let g:netrw_liststyle=3

autocmd FileType html setlocal softtabstop=2 shiftwidth=2 expandtab

execute pathogen#infect()

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
