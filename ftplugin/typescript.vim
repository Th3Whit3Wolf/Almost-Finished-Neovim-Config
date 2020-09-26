packadd yats.vim
packadd vim-jsdoc
packadd vim-graphql
" packadd ale
packadd nvim-treesitter 
packadd completion-treesitter
packadd completion-tags
lua require 'plugins/tree-sitter' 
setlocal foldmethod=expr 
setlocal foldexpr=nvim_treesitter#foldexpr()

nmap <silent> <C-l> <Plug>(jsdoc)
