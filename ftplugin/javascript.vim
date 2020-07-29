packadd vim-javascript
packadd vim-jsx-pretty
packadd vim-closetag
packadd vim-jsdoc
packadd vim-graphql
packadd bracey.vim
packadd vim-gutentags
packadd neoformat

call LazySource('gutentags')
call LazySource('closetag')

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR

set backupcopy=yes

let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1
let g:javascript_conceal_function             = "ƒ"
let g:javascript_conceal_null                 = "ø"
let g:javascript_conceal_this                 = "@"
let g:javascript_conceal_return               = "⇚"
let g:javascript_conceal_undefined            = "¿"
let g:javascript_conceal_NaN                  = "ℕ"
let g:javascript_conceal_prototype            = "¶"
let g:javascript_conceal_static               = "•"
let g:javascript_conceal_super                = "Ω"
let g:javascript_conceal_arrow_function       = "⇒"
let g:javascript_conceal_noarg_arrow_function = "🞅"
let g:javascript_conceal_underscore_arrow_function = "🞅"
nmap <silent> <C-l> <Plug>(jsdoc)

function! RunMyCode()
    if executable('node')
        call Run("node %")
    else
        echo 'Node is not installed!'
    endif
endfunction

autocmd BufWritePre * undojoin | Neoformat