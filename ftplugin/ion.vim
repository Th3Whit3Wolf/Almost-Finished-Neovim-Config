packadd ion-vim

function! RunMyCode()
    if executable('ion')
        call Run("ion %")
    else
        echom 'Ion is not installed!'
    endif
endfunction