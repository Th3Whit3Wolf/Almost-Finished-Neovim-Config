packadd vim-ruby
packadd vim-yardoc
packadd completion-tags
" packadd ale
packadd nvim-treesitter 
packadd completion-treesitter 
lua require 'plugins/tree-sitter' 
setlocal foldmethod=expr 
setlocal foldexpr=nvim_treesitter#foldexpr()

let b:endwise_addition='end'
let b:endwise_words='module,class,def,if,unless,case,while,until,begin,do'
let b:endwise_pattern='^\(.*=\)\?\s*\%(private\s\+\|protected\s\+\|public\s\+\|module_function\s\+\)*\zs\%(module\|class\|def\|if\|unless\|case\|while\|until\|for\|\|begin\)\>\%(.*[^.:@$]\<end\>\)\@!\|\<do\ze\%(\s*|.*|\)\=\s*$'
let b:endwise_syngroups='rubyModule,rubyClass,rubyDefine,rubyControl,rubyConditional,rubyRepeat'

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

