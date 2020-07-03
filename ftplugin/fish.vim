packadd vim-fish
function! RunMyCode()
    if executable('fish')
        call Run("fish %")
    else
        echom 'Fish is not installed!'
    endif
endfunction