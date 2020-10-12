let b:AutoPairs = AutoPairsDefine({'\w\zs<': '>'})

setlocal makeprg=cargo\ build
setlocal errorformat=%f:%l:%c:\ %t%n\ %m

command! Make silent lua require'myplugins/async_make'.make()
nnoremap <silent> <space>m :Make<CR>