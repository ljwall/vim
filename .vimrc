runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

syntax on
set number
set nowrap

set background=dark
colorscheme solarized

vnoremap . :norm.<CR>

set softtabstop=4 shiftwidth=4 tabstop=4 expandtab
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

" Auto close { and [ if immediatly followed by <CR>
inoremap {<CR> {<CR>}<Esc>ko
inoremap [<CR> [<CR>]<Esc>ko

" Window moving
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

map <C-\> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

highlight ShowTrailingWhitespace ctermbg=Red guibg=Red

try
  source ~/.vim/local.vim
catch
  " No such file? No problem; just ignore it.
endtry


autocmd FileType php let b:phpfold_group_iftry = 1
autocmd FileType php let b:phpfold_text_right_lines = 1
