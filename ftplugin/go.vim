packadd vim-go
packadd vim-gutentags
packadd ale

if exists('gofmt') || exists('goimports') || exists('gofumpt') || exists('gofumports')
    packadd neoformat
endif

call LazySource('gutentags')

let g:coc_global_extensions += ['coc-go']

let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_methods = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_hightlight_fields = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR

function! CompileMyCode()
    if executable('go')
        call Run("go build %")
    else
        echo 'Go is not installed!'
    endif
endfunction
function! RunMyCode()
    if executable('go')
        call Run("go run %")
    else
        echo 'Go is not installed!'
    endif
endfunction

autocmd BufWritePre * undojoin | Neoformat