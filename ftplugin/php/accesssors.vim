function! PhpMakeAccessors(...)
    if a:0 == 1
        let l:name = a:1
    else
        let l:name = @"
    endif
    let l:uppername = toupper(strpart(l:name, 0, 1)) . strpart(l:name, 1)
    let l:lowername = tolower(strpart(l:name, 0, 1)) . strpart(l:name, 1)
    execute "normal! mlopublic function get" . l:uppername . "()\<cr>{\<cr>return $this->" . l:lowername . ";\<cr>}\<cr>\<cr>public function set" . l:uppername . "($value)\<cr>{\<cr>$this->" . l:lowername . " = $value;\<cr>return $this;\<cr>}\<cr>\<esc>'l"
endfunction

command! -nargs=? PhpMakeAccessors call PhpMakeAccessors(<args>)

