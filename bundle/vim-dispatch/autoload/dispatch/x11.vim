" dispatch.vim X11 strategy

if exists('g:autoloaded_dispatch_x11')
  finish
endif
let g:autoloaded_dispatch_x11 = 1

function! dispatch#x11#handle(request) abort
  echom "trying X11"
  if $DISPLAY !~# '^:'
    echom "X: no display"
    return 0
  endif
  if (get(a:request, 'background', 0) || a:request.action ==# 'make') &&
        \ (!v:windowid || !executable('wmctrl'))
    echom "X: thing 3"
    return 0
  endif
  if !empty($TERMINAL)
    let terminal = $TERMINAL
  elseif executable('x-terminal-emulator')
    let terminal = 'x-terminal-emulator'
  elseif executable('xterm')
    let terminal = 'xterm'
  else
    echom "X: no terminal"
    return 0
  endif
  if a:request.action ==# 'make'
    if !get(a:request, 'background', 0) && empty(v:servername)
	  echom "X: thing 1"
	  echom !get(a:request, 'background', 0)
	  echom empty(v:servername)
      return 0
    endif
    return dispatch#x11#spawn(terminal, dispatch#prepare_make(a:request), a:request)
  elseif a:request.action ==# 'start'
    return dispatch#x11#spawn(terminal, dispatch#prepare_start(a:request), a:request)
  else
    echom "X: thing 2"
    return 0
  endif
endfunction

function! dispatch#x11#spawn(terminal, command, request) abort
  let command = dispatch#set_title(a:request) . '; ' . a:command
  if a:request.background || a:request.action ==# 'make'
    let command = 'wmctrl -i -a '.v:windowid . ';' . command
  endif
  call system(dispatch#shellescape(a:terminal, '-e', &shell, &shellcmdflag, command). ' &')
  return 1
endfunction

function! dispatch#x11#activate(pid) abort
  let out = system('ps ewww -p '.a:pid)
  let window = matchstr(out, 'WINDOWID=\zs\d\+')
  if !empty(window) && executable('wmctrl')
    call system('wmctrl -i -a '.window)
    return !v:shell_error
  endif
endfunction
