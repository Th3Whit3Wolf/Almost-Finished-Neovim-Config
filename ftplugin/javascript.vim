function! RunMyCode()
    if executable('node')
        call Run("node %")
    else
        echo 'Node is not installed!'
    endif
endfunction

