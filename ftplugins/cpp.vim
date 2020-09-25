packadd vim-cpp-enhanced-highlight
packadd vim-endwise
packadd completion-tags
" packadd ale

let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1

let c_no_curly_error=1

let g:endwise_no_mappings = v:true

function! CompileMyCode()
    if executable('g++')
        call Run("g++ -std=c++17 % -o %< -Wall -Wextra -Wshadow -Wdouble-promotion -Wformat=2 -Wformat-truncation -Wformat-overflow -Wundef -fno-common -ffunction-sections -fdata-sections -O0")
    endif
endfunction
function! RunMyCode()
    if executable('g++')
        call Run("g++ -std=c++17 % -o %< -Wall -Wextra -Wshadow -Wdouble-promotion -Wformat=2 -Wformat-truncation -Wformat-overflow -Wundef -fno-common -ffunction-sections -fdata-sections -O0; ./%<")
    endif
endfunction
