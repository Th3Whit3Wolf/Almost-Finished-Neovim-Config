packadd vim-cpp
packadd vim-endwise
packadd vim-gutentags
packadd ale

if exists('uncrustify') || exists('clang-format') || exists('astyle')
    packadd neoformat
endif

call LazySource('gutentags')

if executable('clangd')
	let g:coc_global_extensions += ['coc-clangd']
endif

let g:endwise_no_mappings = v:true

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR<Plug>DiscretionaryEnd

function! CompileMyCode()
    if executable('gcc')
        call Run("gcc % -o %< -Wall -Wextra -Wshadow -Wdouble-promotion -Wformat=2 -Wformat-truncation -Wformat-overflow -Wundef -fno-common -ffunction-sections -fdata-sections -O0")
    endif
endfunction

function! RunMyCode()
    if executable('gcc')
        call Run("gcc % -o %<  -Wall -Wextra -Wshadow -Wdouble-promotion -Wformat=2 -Wformat-truncation -Wformat-overflow -Wundef -fno-common -ffunction-sections -fdata-sections -O0 ; ./%<")
    endif
endfunction

autocmd BufWritePre * undojoin | Neoformat
