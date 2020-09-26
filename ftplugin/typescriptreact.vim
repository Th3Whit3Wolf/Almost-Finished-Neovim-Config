packadd yats.vim
packadd vim-jsx-pretty
packadd vim-graphql
packadd nvim-treesitter 
packadd completion-treesitter
packadd completion-tags
lua require 'plugins/tree-sitter' 
setlocal foldmethod=expr 
setlocal foldexpr=nvim_treesitter#foldexpr()
