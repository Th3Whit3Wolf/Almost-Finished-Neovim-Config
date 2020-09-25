packadd vim-ruby
packadd vim-endwise
packadd vim-yardoc
packadd completion-tags
" packadd ale
packadd nvim-treesitter 
packadd completion-treesitter 
lua require 'plugins/tree-sitter' 
setlocal foldmethod=expr 
setlocal foldexpr=nvim_treesitter#foldexpr()

let g:endwise_no_mappings = v:true

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
