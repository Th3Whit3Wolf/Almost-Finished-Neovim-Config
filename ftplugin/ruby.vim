packadd vim-ruby

function! RunMyCode()
    if InRailsApp()
        if executable('rails')
            call Run("rails runner %")
        else
            echo 'Rails is not installed!'
        endif
    else
        if executable('ruby')
            call Run("ruby %")
        else
            echo 'Ruby is not installed!'
        endif
    endif
endfunction