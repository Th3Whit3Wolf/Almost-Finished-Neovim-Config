packadd vim-cmake-syntax
packadd vim-cmake
packadd completion-tags
" packadd ale

let b:endwise_addition = '\=submatch(0)==#toupper(submatch(0)) ? "END".submatch(0)."()" : "end".submatch(0)."()"'
let b:endwise_words = 'foreach,function,if,macro,while'
let b:endwise_pattern = '\%(\<end\>.*\)\@<!\<&\>'
let b:endwise_syngroups = 'cmakeStatement,cmakeCommandConditional,cmakeCommandRepeat,cmakeCommand'