packadd vim-markdown
packadd vim-markdown-composer
packadd vim-gutentags

call LazySource('gutentags')
inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_fenced_languages =  ['c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini', 'rs=rust']
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_no_extensions_in_markdown = 1

let g:markdown_composer_open_browser = 0
let g:markdown_composer_custom_css = ['file://' . expand('~/.config/nvim/misc/github.css')]
setlocal spell nofoldenable
let &makeprg='proselint %'

let hr = str2nr(strftime('%H'))
if strftime("%H") >= 7 && strftime("%H") < 19
    let g:markdown_composer_syntax_theme = 'atom-one-light'
else
    let g:markdown_composer_syntax_theme = 'atom-one-dark'
endif

function! RunMyCode()
    ComposerOpen
	ComposerUpdate
endfunction
