" =============================================================================
" Filename: spaceline.vim
" Author: glepnir
" URL: https://github.com/glepnir/spaceline.vim
" License: MIT License
" =============================================================================
function! spaceline#colorscheme#spacer#spacer()
    let s:slc={}
    if &background ==# 'dark'
        let s:slc.purple = ['5d4d7a', 237]    " purple3 / 5d4d7a
        let s:slc.navy = ['292b2e', 237]      " bg0 / 242B38
        let s:slc.lightgray= ['cbc1d5', 188]  " cblk / c0c0c0
        let s:slc.lightblue = ['7590db', 225] " blue1 / 6272a4
        let s:slc.green = ['86dc2f', 148]     " mat / afd700
        let s:slc.gray = ['44505c', 237]      " grey / 3c3836
    else
        let s:slc.purple = ['d3d3e7', 237]    " purple3
        let s:slc.navy = ['fbf8ef', 237]      " bg0
        let s:slc.lightgray= ['655370', 188]  " cblk
        let s:slc.lightblue = ['715ab1', 225] " blue1
        let s:slc.green = ['ba2f59', 148]     " mat
        let s:slc.gray = ['a8a8bf', 237]      " grey
    endif

    let s:slc.yellow = ['e5d11c', 214]  " Yellow1 / fabd2f
    let s:slc.orange  = ['dc752f', 208] " War / FF8800
    let s:slc.red = ['f54e3c', 203]     " Red0 / ec5f67
    let s:slc.teal = ['2aa1ae', 6]      " aqua0 / 008080
    let s:slc.blue = ['4f97d7', 32]     " Blue0 / 0087d7
    let s:slc.aqua= ['4495b4',73]       " aqua / 4495b4
    let s:slc.darknavy=[]

    call spaceline#colors#match_background_color(s:slc.darknavy)

    let l:mode=mode()
    if g:seperate_style  == 'slant'
        call spaceline#colors#spaceline_hl('HomeMode', s:slc, 'teal', 'yellow')
        if empty(expand('%t'))
            call spaceline#colors#spaceline_hl('HomeModeRight',s:slc,  'yellow', 'darknavy')
        else
            call spaceline#colors#spaceline_hl('HomeModeRight',s:slc,  'yellow', 'purple')
        endif
        call spaceline#colors#spaceline_hl('FileNameRight',s:slc, 'navy','purple')
        call spaceline#colors#spaceline_hl('FileSizeRight',s:slc, 'purple','navy')
        call spaceline#colors#spaceline_hl('GitLeft',s:slc,  'navy',  'purple')
        call spaceline#colors#spaceline_hl('GitRight',s:slc,  'darknavy',  'purple')
        call spaceline#colors#spaceline_hl('InActiveHomeRight', s:slc, 'yellow', 'navy')
        call spaceline#colors#spaceline_hl('ShortRight', s:slc, 'yellow', 'navy')
    elseif g:seperate_style  == 'slant-cons'
        call spaceline#colors#spaceline_hl('HomeMode', s:slc, 'teal', 'yellow')
        call spaceline#colors#spaceline_hl('HomeModeRight',s:slc,  'yellow', 'purple')
        call spaceline#colors#spaceline_hl('FileNameRight',s:slc, 'purple','navy')
        call spaceline#colors#spaceline_hl('FileSizeRight',s:slc, 'purple','navy')
        call spaceline#colors#spaceline_hl('GitLeft',s:slc,  'navy',  'purple')
        call spaceline#colors#spaceline_hl('GitRight',s:slc,  'purple',  'darknavy')
        call spaceline#colors#spaceline_hl('InActiveHomeRight', s:slc, 'yellow', 'navy')
        call spaceline#colors#spaceline_hl('ShortRight', s:slc, 'yellow', 'navy')
    elseif g:seperate_style  == 'slant-fade'
        call spaceline#colors#spaceline_hl('HomeMode', s:slc, 'teal', 'yellow')
        call spaceline#colors#spaceline_hl('HomeModeRight',s:slc,  'yellow', 'purple')
        call spaceline#colors#spaceline_hl('FileNameRight',s:slc, 'navy','purple')
        call spaceline#colors#spaceline_hl('FileSizeRight',s:slc, 'purple','navy')
        call spaceline#colors#spaceline_hl('GitLeft',s:slc,  'navy',  'purple')
        call spaceline#colors#spaceline_hl('GitRight',s:slc,  'purple','darknavy')
        call spaceline#colors#spaceline_hl('InActiveHomeRight', s:slc, 'yellow', 'navy')
        call spaceline#colors#spaceline_hl('ShortRight', s:slc, 'yellow', 'navy')
    elseif g:seperate_style  == 'arrow-fade'
        call spaceline#colors#spaceline_hl('HomeMode', s:slc, 'teal', 'yellow')
        call spaceline#colors#spaceline_hl('HomeModeRight',s:slc,  'yellow', 'purple')
        call spaceline#colors#spaceline_hl('FileNameRight',s:slc, 'purple','navy')
        call spaceline#colors#spaceline_hl('FileSizeRight',s:slc, 'purple','navy')
        call spaceline#colors#spaceline_hl('GitLeft',s:slc,  'navy',  'purple')
        call spaceline#colors#spaceline_hl('GitRight',s:slc,  'purple',  'darknavy')
        call spaceline#colors#spaceline_hl('InActiveHomeRight', s:slc, 'yellow', 'navy')
        call spaceline#colors#spaceline_hl('ShortRight', s:slc, 'yellow', 'navy')
    elseif g:seperate_style  == 'curve'
        call spaceline#colors#spaceline_hl('HomeMode', s:slc, 'teal', 'yellow')
        call spaceline#colors#spaceline_hl('HomeModeRight',s:slc,  'purple', 'yellow')
        call spaceline#colors#spaceline_hl('FileNameRight',s:slc, 'purple','navy')
        call spaceline#colors#spaceline_hl('FileSizeRight',s:slc, 'navy','purple')
        call spaceline#colors#spaceline_hl('GitLeft',s:slc,  'navy',  'purple')
        call spaceline#colors#spaceline_hl('GitRight',s:slc,  'purple',  'darknavy')
        call spaceline#colors#spaceline_hl('InActiveHomeRight', s:slc, 'navy', 'yellow')
        call spaceline#colors#spaceline_hl('ShortRight', s:slc, 'navy', 'yellow')
    else
        call spaceline#colors#spaceline_hl('HomeMode', s:slc, 'teal', 'yellow')
        call spaceline#colors#spaceline_hl('HomeModeRight',s:slc,  'purple', 'yellow')
        call spaceline#colors#spaceline_hl('FileNameRight',s:slc, 'purple','navy')
        call spaceline#colors#spaceline_hl('FileSizeRight',s:slc, 'navy','purple')
        call spaceline#colors#spaceline_hl('GitLeft',s:slc,  'navy',  'purple')
        call spaceline#colors#spaceline_hl('GitRight',s:slc,  'navy',  'purple')
        call spaceline#colors#spaceline_hl('InActiveHomeRight', s:slc, 'navy', 'yellow')
        call spaceline#colors#spaceline_hl('ShortRight', s:slc, 'navy', 'yellow')
    endif

    call spaceline#colors#spaceline_hl('InActiveFilename', s:slc, 'lightgray', 'navy')
    call spaceline#colors#spaceline_hl('FileName', s:slc, 'lightgray', 'purple','bold')
    call spaceline#colors#spaceline_hl('Filesize', s:slc, 'green', 'navy')
    call spaceline#colors#spaceline_hl('HeartSymbol', s:slc, 'orange',  'navy')
    call spaceline#colors#spaceline_hl('CocError',s:slc,  'red',  'navy')
    call spaceline#colors#spaceline_hl('CocWarn',s:slc,  'blue',  'navy')
    call spaceline#colors#spaceline_hl('GitBranchIcon',s:slc,  'orange',  'purple')
    call spaceline#colors#spaceline_hl('GitInfo',s:slc,  'lightgray',  'purple','bold')
    call spaceline#colors#spaceline_hl('GitAdd',s:slc,  'green',  'purple')
    call spaceline#colors#spaceline_hl('GitRemove',s:slc,  'red',  'purple')
    call spaceline#colors#spaceline_hl('GitModified',s:slc,  'orange',  'purple')
    call spaceline#colors#spaceline_hl('CocBar',s:slc,  'teal',  'darknavy')
    call spaceline#colors#spaceline_hl('VistaNearest',s:slc,  'teal',  'darknavy')
    if g:seperate_style ==? 'slant'
        call spaceline#colors#spaceline_hl('LineInfoLeft',s:slc,  'darknavy',  'purple')
    else
        call spaceline#colors#spaceline_hl('LineInfoLeft',s:slc,  'purple',  'darknavy')
    endif
    if g:seperate_style ==? 'arrow' || g:seperate_style ==? 'curve' || g:seperate_style ==? 'slant-fade'
        call spaceline#colors#spaceline_hl('LineFormatRight',s:slc,  'purple',  'navy')
    else
        call spaceline#colors#spaceline_hl('LineFormatRight',s:slc,  'navy',  'purple')
    endif
    call spaceline#colors#spaceline_hl('StatusEncod',s:slc,  'lightgray',  'purple')
    call spaceline#colors#spaceline_hl('StatusFileFormat',s:slc,  'lightgray',  'purple')
    call spaceline#colors#spaceline_hl('StatusLineinfo',s:slc,  'lightblue',  'navy')
    call spaceline#colors#spaceline_hl('EndSeperate',s:slc,  'yellow',  'purple')
    call spaceline#colors#spaceline_hl('emptySeperate1',s:slc,  'navy',  'darknavy')
endfunction