packadd completion-tags
" packadd ale
packadd nvim-treesitter 
packadd completion-treesitter 
lua require 'plugins/tree-sitter' 
setlocal foldmethod=expr 
setlocal foldexpr=nvim_treesitter#foldexpr()


function! CompileMyCode()
    if executable('javac')
        call Run("javac %")
    else
        echo 'Java is not installed!'
    endif
endfunction
function! RunMyCode()
    if executable('javac')
        call Run("javac %")
    else
        echo 'Java is not installed!'
    endif
endfunction
