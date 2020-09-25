packadd vim-toml
packadd nvim-treesitter 
packadd completion-treesitter 
lua require 'plugins/tree-sitter' 
setlocal foldmethod=expr 
setlocal foldexpr=nvim_treesitter#foldexpr()

if expand('%') =~ "Cargo.toml"
    packadd vim-crates
    call crates#toggle()
endif
