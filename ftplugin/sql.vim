packadd vim-dotenv
packadd vim-dadbod
packadd ale

if exists('sqlformat', 'pg_format', 'sqlfmt')
    packadd neoformat
endif

setlocal commentstring=--\ %s


" Todo
" Add function to ask user what database type is on Bufenter then:
" * Set syntax
" * Checks for `.env` for db_url
" * Opens dadbod-ui for more visual look at database
"
" Maybe check for dotenv first to see if we can determine the database
"
" packadd pgsql.vim
" packaddvim-dadbod-completion
" packadd vim-dadbod-ui
" let g:db_ui_save_location = '~/.cache/vim/DB/db_ui_queries'
" let g:db_ui_winwidth = 30
" let g:db_ui_icons = {
"     \ 'expanded': '▾',
"     \ 'collapsed': '▸',
"     \ 'saved_query': '*',
"     \ 'new_query': '+',
"     \ 'tables': '~',
"     \ 'buffers': '»',
"     \ 'connection_ok': '✓',
"     \ 'connection_error': '✕',
"     \ }
" let g:db_ui_table_helpers = {
" \   'postgresql': {
" \     'Count': 'select count(*) from "{table}"'
" \   }
" \ }
inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR

function! s:env(var) abort
    return exists('*DotenvGet') ? DotenvGet(a:var) : eval('$'.a:var)
endfunction

let db_url = s:env('DATABASE_URL')

autocmd BufWritePre * undojoin | Neoformat