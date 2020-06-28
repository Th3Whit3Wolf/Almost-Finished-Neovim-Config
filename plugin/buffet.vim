if exists("g:buffet_loaded")
    finish
endif

let g:buffet_loaded = 1

augroup buffet_show_tabline
    autocmd!
    autocmd VimEnter,BufAdd,TabEnter * set showtabline=2
augroup END

set guioptions-=e

let g:buffet_powerline_separators = 1
let g:buffet_noseparator = "\ue0b0"
let g:buffet_separator = "\ue0b1"

let g:buffet_show_index = get(g:, "buffet_show_index", 1)

let g:buffet_bubble_index = get(g:, "buffet_bubble_index", 1)

let g:buffet_max_plug = get(g:, "buffet_max_plug", 10)

let g:buffet_use_devicons = 1
let g:buffet_modified_icon = "\uf459"
let g:buffet_left_trunc_icon = "\uf0a8"
let g:buffet_right_trunc_icon = "\uf0a9"
let g:buffet_new_buffer_name = "*"
let g:buffet_tab_icon = "\uf00a"
let g:buffet_hidden_buffers = ["terminal", "quickfix"]

let g:buffet_prefix = "Buffet"
let g:buffet_has_separator = {
            \     "Tab": {
            \         "Tab": g:buffet_separator,
            \         "LeftTrunc": g:buffet_separator,
            \         "End" : g:buffet_separator,
            \     },
            \     "LeftTrunc": {
            \         "Buffer": g:buffet_separator,
            \         "CurrentBuffer": g:buffet_separator,
            \         "ActiveBuffer": g:buffet_separator,
            \         "ModBuffer": g:buffet_separator,
            \     },
            \     "RightTrunc": {
            \         "Tab": g:buffet_separator,
            \         "End": g:buffet_separator,
            \     },
            \ }

let g:buffet_buffer_types = [
            \    "Buffer",
            \    "ActiveBuffer",
            \    "CurrentBuffer",
            \    "ModBuffer",
            \    "ModActiveBuffer",
            \    "ModCurrentBuffer",
            \ ]

for s:type in g:buffet_buffer_types
    let g:buffet_has_separator["Tab"][s:type] = g:buffet_separator
    let g:buffet_has_separator[s:type] = {
                \     "RightTrunc": g:buffet_separator,
                \     "Tab": g:buffet_separator,
                \     "End": g:buffet_separator,
                \ }

    for s:t in g:buffet_buffer_types
        let g:buffet_has_separator[s:type][s:t] = g:buffet_separator
    endfor
endfor

function! s:GetHiAttr(name, attr)
    let vim_mode = "gui"
    let attr_suffix = "#"

    let value = synIDattr(synIDtrans(hlID(a:name)), a:attr . attr_suffix, vim_mode)

    return value
endfunction

function! s:SetHi(name, fg, bg)
    let vim_mode = "gui"

    let spec = ""
    if a:fg != ""
        let fg_spec = vim_mode . "fg=" . a:fg
        let spec = fg_spec
    endif

    if a:bg != ""
        let bg_spec = vim_mode . "bg=" . a:bg

        if spec != ""
            let bg_spec = " " . bg_spec
        endif

        let spec = spec . bg_spec
    endif

    if spec != ""
        exec "silent hi! " . a:name . " " . spec
    endif
endfunction

function! s:LinkHi(name, target)
    exec "silent hi! link " . a:name . " " . a:target
endfunction

function! s:SetColors()
    " TODO: try to match user's colorscheme
    " Issue: https://github.com/bagrat/vim-buffet/issues/5
    " if get(g:, "buffet_match_color_scheme", 1)

    if &background ==# 'dark'
        hi! BuffetCurrentBuffer cterm=NONE ctermbg=114 ctermfg=240 guibg=#98C379 guifg=#282c34
        hi! BuffetActiveBuffer cterm=NONE ctermbg=251 ctermfg=240 guibg=#C678DD guifg=#282c34
        hi! BuffetBuffer cterm=NONE ctermbg=145 ctermfg=59 guibg=#3e4452 guifg=#abb2bf
        hi! BuffetTrunc cterm=NONE ctermbg=38 ctermfg=145 guibg=#61AFEF guifg=#3e4452
        hi! BuffetTab cterm=NONE ctermbg=18 ctermfg=240 guibg=#56B6C2 guifg=#282c34
    else
        hi! BuffetCurrentBuffer cterm=NONE ctermbg=114 ctermfg=240 guibg=#98C379 guifg=#fafafa
        hi! BuffetActiveBuffer cterm=NONE ctermbg=251 ctermfg=240 guibg=#C678DD guifg=#fafafa
        hi! BuffetBuffer cterm=NONE ctermbg=59 ctermfg=238 guibg=#d0d0d0 guifg=#494b53
        hi! BuffetTrunc cterm=NONE ctermbg=38 ctermfg=238 guibg=#61AFEF guifg=#d0d0d0
        hi! BuffetTab cterm=NONE ctermbg=18 ctermfg=240 guibg=#56B6C2 guifg=#fafafa
    endif

    hi! link BuffetModCurrentBuffer BuffetCurrentBuffer
    hi! link BuffetModActiveBuffer BuffetActiveBuffer
    hi! link BuffetModBuffer BuffetBuffer

    hi! link BuffetLeftTrunc BuffetTrunc
    hi! link BuffetRightTrunc BuffetTrunc
    hi! link BuffetEnd BuffetBuffer

    for left in keys(g:buffet_has_separator)
        for right in keys(g:buffet_has_separator[left])
            let vim_mode = "gui"

            let left_hi = g:buffet_prefix . left
            let right_hi = g:buffet_prefix . right
            let left_bg = s:GetHiAttr(left_hi, 'bg')
            let right_bg = s:GetHiAttr(right_hi, 'bg')

            if left_bg == ""
                let left_bg = "NONE"
            endif

            if right_bg == ""
                let right_bg = "NONE"
            endif

            let sep_hi = g:buffet_prefix . left . right
            if left_bg != right_bg
                let g:buffet_has_separator[left][right] = g:buffet_noseparator

                call s:SetHi(sep_hi, left_bg, right_bg)
            else
                let g:buffet_has_separator[left][right] = g:buffet_separator

                call s:LinkHi(sep_hi, left_hi)
            endif
        endfor
    endfor
endfunction

augroup buffet_set_colors
    autocmd!
    autocmd ColorScheme * call s:SetColors()
augroup end

" Set solors also at the startup
call s:SetColors()


function! SwitchToBuffer(buffer_id, clicks, btn, flags)
    exec "silent buffer " . a:buffer_id
endfunction


function! buffet#bwipe_nerdtree_filter(bang, buffer)
    let is_in_nt = 0
    if exists("t:NERDTreeBufName")
        let ntwinnr = bufwinnr(t:NERDTreeBufName)

        if ntwinnr == winnr()
            let is_in_nt = 1
        endif
    endif

    if is_in_nt
        return 1
    endif
endfunction

let g:buffet_bwipe_filters = ["buffet#bwipe_nerdtree_filter"]

for s:n in range(1, g:buffet_max_plug)
    execute printf("noremap <silent> <Plug>BuffetSwitch(%d) :call buffet#bswitch(%d)<cr>", s:n, s:n)
endfor

command! -bang -complete=buffer -nargs=? Bw call buffet#bwipe(<q-bang>, <q-args>)
command! -bang -complete=buffer -nargs=? Bonly call buffet#bonly(<q-bang>, <q-args>)

set tabline=%!buffet#render()
