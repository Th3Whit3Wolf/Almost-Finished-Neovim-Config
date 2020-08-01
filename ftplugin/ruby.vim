packadd vim-ruby
packadd vim-endwise
packadd vim-yardoc
packadd vim-gutentags
packadd ale

if exists('rufo') || exists('ruby-beautify') || exists('rubocop')
	packadd neoformat
endif

call LazySource('gutentags')

if executable('solargraph')
	let g:coc_global_extensions += ['coc-solargraph']
endif

let g:endwise_no_mappings = v:true

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR<Plug>DiscretionaryEnd

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

autocmd BufWritePre * undojoin | Neoformat