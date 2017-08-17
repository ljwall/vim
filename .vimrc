runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
execute pathogen#helptags()

syntax on
set number
set nowrap

set background=dark
colorscheme solarized

vnoremap . :norm.<CR>

set softtabstop=4 shiftwidth=4 tabstop=4 noexpandtab
set scrolloff=3

augroup tabsettings
  autocmd!
  autocmd FileType html setlocal softtabstop=2 shiftwidth=2 expandtab
  autocmd FileType javascript setlocal noexpandtab
  autocmd FileType php setlocal noexpandtab
augroup END

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

inoremap <c-c> <esc>
inoremap kj <esc>

" Window moving
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

augroup phpsettings
  autocmd!
  autocmd FileType php let b:phpfold_group_iftry = 1
  autocmd FileType php let b:phpfold_text_right_lines = 1
  autocmd FileType php inoremap <c-d> ->
augroup END

augroup jssettings
  autocmd!
  autocmd FileType javascript setlocal foldmethod=syntax
augroup END

augroup netrw_mapping
  autocmd!
  autocmd BufNewFile,BufRead,filetype * call SetToggleKey()
augroup END

function! SetToggleKey()
  if &ft == 'netrw'
    noremap <buffer> <C-\> :Rexplore<cr>
  else
    noremap <buffer> <C-\> :Explore<cr>
  endif
endfunction

try
  source ~/.vim/local.vim
catch
  " No such file? No problem; just ignore it.
endtry

" Don't use the arrrow keys
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

" Use PreserveNoEOL plugin to stop adding an EOL to last line if there is not
" one there to start with. (Although they should always be there, don't want
" to create spurious diffs in commits.)
let g:PreserveNoEOL = 1

" Settings for CtrlP
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40
set wildignore+=*.so,*.swp,*.zip
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_by_filename=1
let g:ctrlp_regexp=1
let g:ctrlp_clear_cache_on_exit=0
let g:ctrlp_lazy_update=1
let g:ctrlp_match_window = 'max:25'

" Settings for Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
"let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


" Settings for status line
set statusline=%#DiffAdd#%{fugitive#statusline()}%#DiffText#\ %t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%=%#DiffChange#%c,%l/%L%#ErrorMsg#%{StatuslineTabWarning()}%{StatuslineTrailingSpaceWarning()}
augroup BgHighlight
    autocmd!
    autocmd WinLeave * setl statusline=%#LineNr#%{fugitive#statusline()}\ %t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%=%c,%l/%L%{StatuslineTabWarning()}%{StatuslineTrailingSpaceWarning()}
    autocmd WinEnter * setl statusline<
augroup END

set t_Co=16
set laststatus=2

set updatetime=500
"recalculate the tab warning flag when idle and after writing
autocmd CursorHold,BufWritePost * unlet! b:statusline_tab_warning

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let tabs = search('^\t', 'nw') != 0
        let spaces = search('^ [^\*]', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning =  '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        else
            let b:statusline_tab_warning = ''
        endif
    endif
    return b:statusline_tab_warning
endfunction

"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

"return '[\s\+$]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")
        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s\+$]'
            match ErrorMsg /\s\+\%#\@<!$/
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction
