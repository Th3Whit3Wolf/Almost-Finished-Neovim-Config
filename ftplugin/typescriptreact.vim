packadd yats.vim
packadd vim-jsx-pretty
packadd vim-graphql
packadd completion-tags
packadd nvim-treesitter 
packadd completion-treesitter 
lua require 'plugins/tree-sitter' 
setlocal foldmethod=expr 
setlocal foldexpr=nvim_treesitter#foldexpr()
