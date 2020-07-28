packadd vim-markdown
packadd vim-markdown-composer
packadd vim-gutentags
packadd vim-lexical
packadd vim-pencil
packadd vim-ditto

DittoOn

call lexical#init()
call pencil#init({'wrap': 'hard'})
call LazySource('gutentags')

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR

let g:lexical#thesaurus = ['~/.config/nvim/thesaurus/mthesaur.txt', '~/.config/nvim/moby_thesaurus.txt']
let g:lexical#dictionary = ['/usr/share/dict/words']
let g:lexical#spellfile = ['~/.config/nvim/spell/en.utf-8.add']
let g:lexical#thesaurus_key = '<leader>t'
let g:lexical#dictionary_key = '<leader>k'

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

" Check if repository
" If yes change to github flavored markdown
function! s:CheckIfGithub()
    " call asyncrun#run('', {'mode': 'async', 'cwd': '<root>', 'raw': 1},'git remote show origin | grep "Push  URL" | grep "github.com/" | wc -l')
    let cwd = getcwd()
    let parent_dir = expand('%:p:h')
    exe 'cd ' . parent_dir
	let github = system('git remote show origin | grep "Push  URL" | grep "github.com/" | wc -l')
    exe 'cd ' . cwd
	" if in a git repo
	if !v:shell_error && github > 0
        packadd vim-gfm-syntax
        let b:gfm_syntax_enable = 1
        let g:gfm_syntax_enable_always = 0
        let g:markdown_fenced_languages = ['cpp', 'ruby', 'json']
	endif
endfunction

autocmd BufEnter * call s:CheckIfGithub()