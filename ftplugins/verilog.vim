packadd completion-tags
" packadd ale

let b:endwise_addition = '\="end" . submatch(0)'
let b:endwise_words = 'begin,module,case,function,primitive,specify,task'
let b:endwise_pattern = '\<\%(\zs\zebegin\|module\|case\|function\|primitive\|specify\|task\)\>.*$'
let b:endwise_syngroups = 'verilogConditional,verilogLabel,verilogStatement'