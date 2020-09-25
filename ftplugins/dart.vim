packadd dart-vim-plugin
"packadd ale
packadd nvim-treesitter 
packadd completion-treesitter 
lua require 'plugins/tree-sitter' 
setlocal foldmethod=expr 
setlocal foldexpr=nvim_treesitter#foldexpr()

let g:dart_html_in_string=v:true
let g:dart_style_guide = 2
let g:dart_format_on_save = 1

