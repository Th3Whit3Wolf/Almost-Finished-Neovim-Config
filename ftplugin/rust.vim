packadd rust.vim
packadd vim-rust-syntax-ext
packadd vim-gutentags

call LazySource('gutentags')
inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR

let g:rustfmt_autosave = 1
let g:rust_fold = 1
set colorcolumn=9999
setlocal tags=./rusty-tags.vi;/

function! CompileMyCode() abort
    if InCargoProject()
        if executable('cargo')
            call Run("cargo build")
        else
            echom 'Cargo is not installed!'
        endif
    else
        if executable('rustc')
            call Run("rustc % -o %<")
        else
            echom 'Rustc is not installed or this is not a cargo project'
        endif
    endif
endfunction!

function! RunMyCode() abort
    if InCargoProject()
        if executable('cargo')
            call Run("cargo run")
        else
            echom 'Cargo is not installed!'
        endif
    else
        if executable('rustc')
            call Run("rustc % -o %<; ./%<")
        else
            echom 'Rustc is not installed!'
        endif
    endif
endfunction!

function! TestMyCode()
	if InCargoProject()
        if executable('cargo')
          packadd asyncrun.vim
          let g:asyncrun_open = 8
          "AsyncRun -mode=term -pos=hide -name=Running\ Tests -post=echo\ g:asyncrun_name cargo test 2>/dev/null | grep 'test result' | cut -d ':' -f2
          call Run("cargo test --all -- --test-threads=1")
        else
            echo 'Rust is not installed or this is not a cargo project'
        endif
    else
        echom "Testing is only support for Cargo projects"
    endif
endfunction!
