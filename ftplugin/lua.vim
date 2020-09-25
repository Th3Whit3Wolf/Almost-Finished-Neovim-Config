packadd vim-lua
packadd completion-tags
" packadd ale
packadd nvim-treesitter 
packadd completion-treesitter 
lua require 'plugins/tree-sitter' 
setlocal foldmethod=expr 
setlocal foldexpr=nvim_treesitter#foldexpr()

let g:lua_syntax_fancynotequal = 1

let b:endwise_addition = 'end'
let b:endwise_words = 'function,do,then'
let b:endwise_pattern = '^\s*\zs\%(\%(local\s\+\)\=function\)\>\%(.*\<end\>\)\@!\|\<\%(then\|do\)\ze\s*$'
let b:endwise_syngroups = 'luaFunction,luaStatement,luaCond'

if !stridx(&rtp, resolve(expand('~/.config/nvim/lazy/git.vim'))) == 0
    execute 'source' fnameescape(resolve(expand('~/.config/nvim/lazy/vim-endwise.vim')))
endif

imap <buffer> <CR> <CR><Plug>DiscretionaryEnd