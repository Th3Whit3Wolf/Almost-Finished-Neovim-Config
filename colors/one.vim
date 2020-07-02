" Name:    one vim colorscheme
" Author:  Ramzi Akremi
" License: MIT
" Version: 1.1.1-pre

" Global setup =============================================================={{{

if exists("*<SID>X")
  delf <SID>X
  delf <SID>XAPI
  delf <SID>rgb
  delf <SID>color
  delf <SID>rgb_color
  delf <SID>rgb_level
  delf <SID>rgb_number
  delf <SID>grey_color
  delf <SID>grey_level
  delf <SID>grey_number
  delf <SID>user_color_palette
endif

hi clear
syntax reset
if exists('g:colors_name')
  unlet g:colors_name
endif
let g:colors_name = 'one'
let s:italic = 'italic'


if has('gui_running') || has('termguicolors') || &t_Co == 88 || &t_Co == 256
  " functions
  " returns an approximate grey index for the given grey level

  " Utility functions -------------------------------------------------------{{{
  fun <SID>grey_number(x)
    if &t_Co == 88
      if a:x < 23
        return 0
      elseif a:x < 69
        return 1
      elseif a:x < 103
        return 2
      elseif a:x < 127
        return 3
      elseif a:x < 150
        return 4
      elseif a:x < 173
        return 5
      elseif a:x < 196
        return 6
      elseif a:x < 219
        return 7
      elseif a:x < 243
        return 8
      else
        return 9
      endif
    else
      if a:x < 14
        return 0
      else
        let l:n = (a:x - 8) / 10
        let l:m = (a:x - 8) % 10
        if l:m < 5
          return l:n
        else
          return l:n + 1
        endif
      endif
    endif
  endfun

  " returns the actual grey level represented by the grey index
  fun <SID>grey_level(n)
    if &t_Co == 88
      if a:n == 0
        return 0
      elseif a:n == 1
        return 46
      elseif a:n == 2
        return 92
      elseif a:n == 3
        return 115
      elseif a:n == 4
        return 139
      elseif a:n == 5
        return 162
      elseif a:n == 6
        return 185
      elseif a:n == 7
        return 208
      elseif a:n == 8
        return 231
      else
        return 255
      endif
    else
      if a:n == 0
        return 0
      else
        return 8 + (a:n * 10)
      endif
    endif
  endfun

  " returns the palette index for the given grey index
  fun <SID>grey_color(n)
    if &t_Co == 88
      if a:n == 0
        return 16
      elseif a:n == 9
        return 79
      else
        return 79 + a:n
      endif
    else
      if a:n == 0
        return 16
      elseif a:n == 25
        return 231
      else
        return 231 + a:n
      endif
    endif
  endfun

  " returns an approximate color index for the given color level
  fun <SID>rgb_number(x)
    if &t_Co == 88
      if a:x < 69
        return 0
      elseif a:x < 172
        return 1
      elseif a:x < 230
        return 2
      else
        return 3
      endif
    else
      if a:x < 75
        return 0
      else
        let l:n = (a:x - 55) / 40
        let l:m = (a:x - 55) % 40
        if l:m < 20
          return l:n
        else
          return l:n + 1
        endif
      endif
    endif
  endfun

  " returns the actual color level for the given color index
  fun <SID>rgb_level(n)
    if &t_Co == 88
      if a:n == 0
        return 0
      elseif a:n == 1
        return 139
      elseif a:n == 2
        return 205
      else
        return 255
      endif
    else
      if a:n == 0
        return 0
      else
        return 55 + (a:n * 40)
      endif
    endif
  endfun

  " returns the palette index for the given R/G/B color indices
  fun <SID>rgb_color(x, y, z)
    if &t_Co == 88
      return 16 + (a:x * 16) + (a:y * 4) + a:z
    else
      return 16 + (a:x * 36) + (a:y * 6) + a:z
    endif
  endfun

  " returns the palette index to approximate the given R/G/B color levels
  fun <SID>color(r, g, b)
    " get the closest grey
    let l:gx = <SID>grey_number(a:r)
    let l:gy = <SID>grey_number(a:g)
    let l:gz = <SID>grey_number(a:b)

    " get the closest color
    let l:x = <SID>rgb_number(a:r)
    let l:y = <SID>rgb_number(a:g)
    let l:z = <SID>rgb_number(a:b)

    if l:gx == l:gy && l:gy == l:gz
      " there are two possibilities
      let l:dgr = <SID>grey_level(l:gx) - a:r
      let l:dgg = <SID>grey_level(l:gy) - a:g
      let l:dgb = <SID>grey_level(l:gz) - a:b
      let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
      let l:dr = <SID>rgb_level(l:gx) - a:r
      let l:dg = <SID>rgb_level(l:gy) - a:g
      let l:db = <SID>rgb_level(l:gz) - a:b
      let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
      if l:dgrey < l:drgb
        " use the grey
        return <SID>grey_color(l:gx)
      else
        " use the color
        return <SID>rgb_color(l:x, l:y, l:z)
      endif
    else
      " only one possibility
      return <SID>rgb_color(l:x, l:y, l:z)
    endif
  endfun

  " returns the palette index to approximate the 'rrggbb' hex string
  fun <SID>rgb(rgb)
    let l:r = ('0x' . strpart(a:rgb, 0, 2)) + 0
    let l:g = ('0x' . strpart(a:rgb, 2, 2)) + 0
    let l:b = ('0x' . strpart(a:rgb, 4, 2)) + 0

    return <SID>color(l:r, l:g, l:b)
  endfun

  " sets the highlighting for the given group
  fun <SID>XAPI(group, fg, bg, attr)
    let l:attr = a:attr
    if l:attr ==? 'italic'
      let l:attr= 'none'
    endif

    let l:bg = substitute(a:bg, '#', '', '')
    let l:fg = substitute(a:fg, '#', '', '')
    let l:decoration = ""

    if a:bg != ''
      let l:bg = " guibg=#" . l:bg . " ctermbg=" . <SID>rgb(l:bg)
    endif

    if a:fg != ''
      let l:fg = " guifg=#" . l:fg . " ctermfg=" . <SID>rgb(l:fg)
    endif

    if a:attr != ''
      let l:decoration = " gui=" . l:attr . " cterm=" . l:attr
    endif

    let l:exec = l:fg . l:bg . l:decoration

    if l:exec != ''
      exec "hi " . a:group . l:exec
    endif

  endfun

  " Highlight function
  " the original one is borrowed from mhartington/oceanic-next
  function! <SID>X(group, fg, bg, attr, ...)
    let l:attrsp = get(a:, 1, "")
    " fg, bg, attr, attrsp
    if !empty(a:fg)
      exec "hi " . a:group . " guifg=" .  a:fg[0]
      exec "hi " . a:group . " ctermfg=" . a:fg[1]
    endif
    if !empty(a:bg)
      exec "hi " . a:group . " guibg=" .  a:bg[0]
      exec "hi " . a:group . " ctermbg=" . a:bg[1]
    endif
    if a:attr != ""
      exec "hi " . a:group . " gui=" .   a:attr
      exec "hi " . a:group . " cterm=" . a:attr
    endif
    if !empty(l:attrsp)
      exec "hi " . a:group . " guisp=" . l:attrsp[0]
    endif
  endfun

  " replace predefined colors with user defined ones
  fun <SID>user_color_palette(style)
    let l:color= ['', '']
    for i in ['mono_1', 'mono_2', 'mono_3', 'mono_4',
      \ 'hue_1', 'hue_2', 'hue_3', 'hue_4',
      \ 'hue_5', 'hue_5_2', 'hue_6', 'hue_6_2',
      \ 'syntax_bg', 'syntax_gutter', 'syntax_cursor', 'syntax_accent', 'syntax_accent_2',
      \ 'vertsplit', 'special_grey', 'visual_grey', 'pmenu',
      \ 'syntax_fg', 'syntax_fold_bg' ]
      if exists('g:one_' . a:style . '_' . i)
        exe 'let l:color[0] = g:one_' . a:style . '_' . i
        let l:color[0] = substitute(l:color[0], '#', '', '')
        let l:color[1] = <SID>rgb(l:color[0])
        let l:color[0] = '#' . l:color[0]
        exe 'let s:' . i . '=l:color'
      endif
    endfor
  endfun

  " }}}


  " Color definition --------------------------------------------------------{{{
  let s:dark = 0
  if &background ==# 'dark'
    let s:dark = 1
    let s:mono_1 = ['#abb2bf', '145']
    let s:mono_2 = ['#828997', '102']
    let s:mono_3 = ['#5c6370', '59']
    let s:mono_4 = ['#4b5263', '59']

    let s:hue_1  = ['#56b6c2', '73'] " cyan
    let s:hue_2  = ['#61afef', '75'] " blue
    let s:hue_3  = ['#c678dd', '176'] " purple
    let s:hue_4  = ['#98c379', '114'] " green

    let s:hue_5   = ['#e06c75', '168'] " red 1
    let s:hue_5_2 = ['#be5046', '130'] " red 2

    let s:hue_6   = ['#d19a66', '173'] " orange 1
    let s:hue_6_2 = ['#e5c07b', '180'] " orange 2

    let s:syntax_bg     = ['#282c34', '16']
    let s:syntax_gutter = ['#636d83', '60']
    let s:syntax_cursor = ['#2c323c', '16']

    let s:syntax_accent = ['#528bff', '69']

    let s:vertsplit    = ['#181a1f', '233']
    let s:special_grey = ['#3b4048', '16']
    let s:visual_grey  = ['#3e4452', '17']
    let s:pmenu        = ['#333841', '16']

    let s:syntax_fg = s:mono_1
    let s:syntax_fold_bg = s:mono_3

    call <SID>user_color_palette('dark')
  else
    let s:mono_1 = ['#494b53', '23']
    let s:mono_2 = ['#696c77', '60']
    let s:mono_3 = ['#a0a1a7', '145']
    let s:mono_4 = ['#c2c2c3', '250']

    let s:hue_1  = ['#0184bc', '31'] " cyan
    let s:hue_2  = ['#4078f2', '33'] " blue
    let s:hue_3  = ['#a626a4', '127'] " purple
    let s:hue_4  = ['#50a14f', '71'] " green

    let s:hue_5   = ['#e45649', '166'] " red 1
    let s:hue_5_2 = ['#ca1243', '160'] " red 2

    let s:hue_6   = ['#986801', '94'] " orange 1
    let s:hue_6_2 = ['#c18401', '136'] " orange 2

    let s:syntax_bg     = ['#fafafa', '255']
    let s:syntax_gutter = ['#9e9e9e', '247']
    let s:syntax_cursor = ['#f0f0f0', '254']

    let s:syntax_accent = ['#526fff', '63']
    let s:syntax_accent_2 = ['#0083be', '31']

    let s:vertsplit    = ['#e7e9e1', '188']
    let s:special_grey = ['#d3d3d3', '251']
    let s:visual_grey  = ['#d0d0d0', '251']
    let s:pmenu        = ['#dfdfdf', '253']

    let s:syntax_fg = s:mono_1
    let s:syntax_fold_bg = s:mono_3

    call <SID>user_color_palette('light')
  endif

  " }}}

  " Pre-define some hi groups -----------------------------------------------{{{
  call <sid>X('OneMono1', s:mono_1, '', '')  " Opposite of bg
  call <sid>X('OneMono2', s:mono_2, '', '')
  call <sid>X('OneMono3', s:mono_3, '', '')  " COMMENT Grey
  call <sid>X('OneMono4', s:mono_4, '', '') " gutter_fg_grey

  call <sid>X('OneHue1', s:hue_1, '', '')    " 1 CYAN
  call <sid>X('OneHue2', s:hue_2, '', '')    " 2 BLUE
  call <sid>X('OneHue3', s:hue_3, '', '')    " 3 PURPLE
  call <sid>X('OneHue4', s:hue_4, '', '')    " 4 GREEN
  call <sid>X('OneHue5', s:hue_5, '', '')    " 5 RED
  call <sid>X('OneHue52', s:hue_5_2, '', '') " 52 DARK RED
  call <sid>X('OneHue6', s:hue_6, '', '')    " 6 DARK YELLOW
  call <sid>X('OneHue62', s:hue_6_2, '', '') " 62 YELLOW

  hi! link OneSyntaxFg OneMono1
  " }}}

  " Vim editor color --------------------------------------------------------{{{
  call <sid>X('Normal',       s:syntax_fg,     s:syntax_bg,      '')
  call <sid>X('bold',         '',              '',               'bold')
  call <sid>X('ColorColumn',  '',              s:syntax_cursor,  '')
  call <sid>X('Conceal',      s:mono_4,        s:syntax_bg,      '')
  call <sid>X('Cursor',       '',              s:syntax_accent,  '')
  call <sid>X('CursorIM',     '',              '',               '')
  call <sid>X('CursorColumn', '',              s:syntax_cursor,  '')
  if &diff
    call <sid>X('CursorLine',   '',              '',  'underline')
  else
    call <sid>X('CursorLine',   '',              s:syntax_cursor,  'none')
  endif
  hi! link Directory OneHue2
  call <sid>X('ErrorMsg',     s:hue_5,         s:syntax_bg,      'none')
  call <sid>X('VertSplit',    s:vertsplit,     '',               'none')
  call <sid>X('Folded',       s:syntax_bg,     s:syntax_fold_bg, 'none')
  call <sid>X('FoldColumn',   s:mono_3,        s:syntax_cursor,  '')
  hi! link IncSearch OneHue6
  hi! link LineNr OneMono4
  call <sid>X('CursorLineNr', s:syntax_fg,     s:syntax_cursor,  'none')
  call <sid>X('MatchParen',   s:hue_5,         s:syntax_cursor,  'underline,bold')
  call <sid>X('Italic',       '',              '',               s:italic)
  hi! link ModeMsg OneSyntaxFg
  hi! link MoreMsg OneSyntaxFg
  call <sid>X('NonText',      s:mono_3,        '',               'none')
  call <sid>X('PMenu',        '',              s:pmenu,          '')
  call <sid>X('PMenuSel',     '',              s:mono_4,         '')
  call <sid>X('PMenuSbar',    '',              s:syntax_bg,      '')
  call <sid>X('PMenuThumb',   '',              s:mono_1,         '')
  hi! link Question OneHue2
  call <sid>X('Search',       s:syntax_bg,     s:hue_6_2,        '')
  call <sid>X('SpecialKey',   s:special_grey,  '',               'none')
  call <sid>X('Whitespace',   s:special_grey,  '',               'none')
  call <sid>X('StatusLine',   s:syntax_fg,     s:syntax_cursor,  'none')
  hi! link StatusLineNC OneMono3
  call <sid>X('TabLine',      s:mono_1,        s:syntax_bg,      '')
  call <sid>X('TabLineFill',  s:mono_3,        s:visual_grey,    'none')
  call <sid>X('TabLineSel',   s:syntax_bg,     s:hue_2,          '')
  call <sid>X('Title',        s:syntax_fg,     '',               'bold')
  call <sid>X('Visual',       '',              s:visual_grey,    '')
  call <sid>X('VisualNOS',    '',              s:visual_grey,    '')
  hi! link WarningMsg OneHue5
  hi! link TooLong OneHue5
  call <sid>X('WildMenu',     s:syntax_fg,     s:mono_3,         '')
  call <sid>X('SignColumn',   '',              s:syntax_bg,      '')
  hi! link Special OneHue2
  " }}}

  " Vim Help highlighting ---------------------------------------------------{{{
  hi! link helpCommand OneHue62
  hi! link helpExample OneHue62
  call <sid>X('helpHeader',       s:mono_1,  '', 'bold')
  hi! link helpSectionDelim OneMono3
  " }}}

  " Standard syntax highlighting --------------------------------------------{{{
  call <sid>X('Comment',        s:mono_3,        '',          s:italic)
  hi! link Constant OneHue4
  hi! link String OneHue4
  hi! link Character OneHue4
  hi! link Number OneHue6
  hi! link Boolean OneHue6
  hi! link Float OneHue6
  call <sid>X('Identifier',     s:hue_5,         '',          'none')
  hi! link Function OneHue2
  hi! link Statement OneHue3
  hi! link Conditional OneHue3
  hi! link Repeat OneHue3
  hi! link Label OneHue3
  call <sid>X('Operator',       s:syntax_accent, '',          'none')
  hi! link Keyword OneHue5
  hi! link Exception OneHue3
  hi! link PreProc OneHue62
  hi! link Include OneHue2
  hi! link Define OneHue3
  hi! link Macro OneHue3
  hi! link PreCondit OneHue62
  hi! link Type OneHue62
  hi! link StorageClass OneHue62
  hi! link Structure OneHue62
  hi! link Typedef OneHue62
  hi! link Special OneHue2
  call <sid>X('SpecialChar',    '',              '',          '')
  call <sid>X('Tag',            '',              '',          '')
  call <sid>X('Delimiter',      '',              '',          '')
  call <sid>X('SpecialComment', '',              '',          '')
  call <sid>X('Debug',          '',              '',          '')
  call <sid>X('Underlined',     '',              '',          'underline')
  call <sid>X('Ignore',         '',              '',          '')
  call <sid>X('Error',          s:hue_5,         s:syntax_bg, 'bold')
  hi! link Todo OneHue3
  " }}}

  " Diff highlighting -------------------------------------------------------{{{
  call <sid>X('DiffAdd',     s:hue_4, s:visual_grey, '')
  call <sid>X('DiffChange',  s:hue_6, s:visual_grey, '')
  call <sid>X('DiffDelete',  s:hue_5, s:visual_grey, '')
  hi! link DiffText OneHue2
  call <sid>X('DiffAdded',   s:hue_4, s:visual_grey, '')
  call <sid>X('DiffFile',    s:hue_5, s:visual_grey, '')
  call <sid>X('DiffNewFile', s:hue_4, s:visual_grey, '')
  hi! link DiffLine OneHue2
  call <sid>X('DiffRemoved', s:hue_5, s:visual_grey, '')
  " }}}

  " Asciidoc highlighting ---------------------------------------------------{{{
  hi! link asciidocListingBlock OneMono2
  " }}}

  " C/C++ highlighting ------------------------------------------------------{{{
  hi! link cInclude OneHue3
  hi! link cPreCondit OneHue3
  hi! link cPreConditMatch OneHue3

  hi! link cType OneHue3
  hi! link cStorageClass OneHue3
  hi! link cStructure OneHue3
  hi! link cOperator OneHue3
  hi! link cStatement OneHue3
  hi! link cTODO OneHue3
  hi! link cConstant OneHue6
  hi! link cSpecial OneHue1
  hi! link cSpecialCharacter OneHue1
  hi! link cString OneHue4

  hi! link cppType OneHue3
  hi! link cppStorageClass OneHue3
  hi! link cppStructure OneHue3
  hi! link cppModifier OneHue3
  hi! link cppOperator OneHue3
  hi! link cppAccess OneHue3
  hi! link cppStatement OneHue3
  hi! link cppConstant OneHue5
  hi! link cCppString OneHue4
  " }}}

  " Cucumber highlighting ---------------------------------------------------{{{
  hi! link cucumberGiven OneHue2
  hi! link cucumberWhen OneHue2
  hi! link cucumberWhenAnd OneHue2
  hi! link cucumberThen OneHue2
  hi! link cucumberThenAnd OneHue2
  hi! link cucumberUnparsed OneHue6
  call <sid>X('cucumberFeature',         s:hue_5,  '', 'bold')
  hi! link cucumberBackground OneHue3
  hi! link cucumberScenario OneHue3
  hi! link cucumberScenarioOutline OneHue3
  call <sid>X('cucumberTags',            s:mono_3, '', 'bold')
  call <sid>X('cucumberDelimiter',       s:mono_3, '', 'bold')
  " }}}

  " CSS/Sass highlighting ---------------------------------------------------{{{
  hi! link cssAttrComma OneHue3
  hi! link cssAttributeSelector OneHue4
  hi! link cssBraces OneMono2
  hi! link cssClassName OneHue6
  hi! link cssClassNameDot OneHue6
  hi! link cssDefinition OneHue3
  hi! link cssFontAttr OneHue6
  hi! link cssFontDescriptor OneHue3
  hi! link cssFunctionName OneHue2
  hi! link cssIdentifier OneHue2
  hi! link cssImportant OneHue3
  hi! link cssInclude OneMono1
  hi! link cssIncludeKeyword OneHue3
  hi! link cssMediaType OneHue6
  hi! link cssProp OneHue1
  hi! link cssPseudoClassId OneHue6
  hi! link cssSelectorOp OneHue3
  hi! link cssSelectorOp2 OneHue3
  hi! link cssStringQ OneHue4
  hi! link cssStringQQ OneHue4
  hi! link cssTagName OneHue5
  hi! link cssAttr OneHue6

  hi! link sassAmpersand OneHue5
  hi! link sassClass OneHue62
  hi! link sassControl OneHue3
  hi! link sassExtend OneHue3
  hi! link sassFor OneMono1
  hi! link sassFunction OneHue1
  hi! link sassId OneHue2
  hi! link sassInclude OneHue3
  hi! link sassProperty OneHue1
  hi! link sassMedia OneHue3
  hi! link sassMediaOperators OneMono1
  hi! link sassMixin OneHue3
  hi! link sassMixinName OneHue2
  hi! link sassMixing OneHue3
  hi! link sassVariable OneHue3

  hi! link scssExtend OneHue3
  hi! link scssImport OneHue3
  hi! link scssInclude OneHue3
  hi! link scssMixin OneHue3
  hi! link scssSelectorName OneHue62
  hi! link scssVariable OneHue3
  " }}}

  " Elixir highlighting------------------------------------------------------{{{
  hi! link elixirModuleDefine Define
  hi! link elixirAlias OneHue62
  hi! link elixirAtom OneHue1
  hi! link elixirBlockDefinition OneHue3
  hi! link elixirModuleDeclaration OneHue6
  hi! link elixirInclude OneHue5
  hi! link elixirOperator OneHue6
  " }}}

  " Fish shell highlighting--------------------------------------------------{{{
  hi! link fishKeyword OneHue3
  hi! link fishConditional OneHue3
  " }}}

  " Git and git related plugins highlighting --------------------------------{{{
  hi! link gitcommitComment OneMono3
  hi! link gitcommitUnmerged OneHue4
  call <sid>X('gitcommitOnBranch',      '',        '', '')
  hi! link gitcommitBranch OneHue3
  hi! link gitcommitDiscardedType OneHue5
  hi! link gitcommitSelectedType OneHue4
  call <sid>X('gitcommitHeader',        '',        '', '')
  hi! link gitcommitUntrackedFile OneHue1
  hi! link gitcommitDiscardedFile OneHue5
  hi! link gitcommitSelectedFile OneHue4
  hi! link gitcommitUnmergedFile OneHue62
  call <sid>X('gitcommitFile',          '',        '', '')
  hi! link gitcommitNoBranch       gitcommitBranch
  hi! link gitcommitUntracked      gitcommitComment
  hi! link gitcommitDiscarded      gitcommitComment
  hi! link gitcommitSelected       gitcommitComment
  hi! link gitcommitDiscardedArrow gitcommitDiscardedFile
  hi! link gitcommitSelectedArrow  gitcommitSelectedFile
  hi! link gitcommitUnmergedArrow  gitcommitUnmergedFile

  hi! link SignifySignAdd OneHue4
  hi! link SignifySignChange OneHue62
  hi! link SignifySignDelete OneHue5
  hi! link GitGutterAdd    SignifySignAdd
  hi! link GitGutterChange SignifySignChange
  hi! link GitGutterDelete SignifySignDelete
  hi! link diffAdded OneHue4
  hi! link diffRemoved OneHue5
  " }}}

  " Go highlighting ---------------------------------------------------------{{{
  hi! link goBuiltins OneHue1
  hi! link goConst OneHue3
  hi! link goDeclType OneHue1
  hi! link goDeclaration OneHue3
  hi! link goField OneHue5
  hi! link goFunctionCall OneHue2
  hi! link goMethod OneHue1
  hi! link goType OneHue62
  hi! link goTypeName OneHue62
  hi! link goTypeDecl OneHue3
  hi! link goUnsignedInts OneHue1
  hi! link goVar OneHue3
  hi! link goVarDefs OneHue5
  hi! link goVarAssign OneHue5
  " }}}

  " Haskell highlighting ----------------------------------------------------{{{
  hi! link haskellDeclKeyword OneHue2
  hi! link haskellType OneHue4
  hi! link haskellWhere OneHue5
  hi! link haskellImportKeywords OneHue2
  hi! link haskellOperators OneHue5
  hi! link haskellDelimiter OneHue2
  hi! link haskellIdentifier OneHue6
  hi! link haskellKeyword OneHue5
  hi! link haskellNumber OneHue1
  hi! link haskellString OneHue1
  "}}}

  " HTML highlighting -------------------------------------------------------{{{
  hi! link htmlArg OneHue6
  call <sid>X('htmlBold', s:hue_6, '', 'bold')
  hi! link htmlH1 OneHue5
  hi! link htmlH2 OneHue5
  hi! link htmlH3 OneHue5
  hi! link htmlH4 OneHue5
  hi! link htmlH5 OneHue5
  hi! link htmlH6 OneHue5
  call <sid>X('htmlItalic', s:hue_3, '', 'italic')
  call <sid>X('htmlLink', s:hue_1, '', 'underline')
  hi! link htmlSpecialChar OneHue6
  hi! link htmlSpecialTagName OneHue5
  hi! link htmlTag OneMono2
  hi! link htmlTagN OneHue5
  hi! link htmlEndTag OneMono2
  hi! link htmlTagName OneHue5
  hi! link htmlTagN OneHue5
  hi! link htmlTitle OneMono1

  call <sid>X('MatchTag', s:hue_5, s:syntax_cursor, 'underline,bold')
  " }}}

  " JavaScript highlighting -------------------------------------------------{{{
  hi! link coffeeString OneHue4

  hi! link javaScriptBraces OneMono1
  hi! link javaScriptFunction OneHue3
  hi! link javaScriptIdentifier OneHue3
  hi! link javaScriptNull OneHue6
  hi! link javaScriptNumber OneHue6
  hi! link javaScriptRequire OneHue1
  hi! link javaScriptReserved OneHue3
  " https://github.com/pangloss/vim-javascript
  hi! link jsArrowFunction OneHue3
  hi! link jsBraces OneMono2
  hi! link jsClassBraces OneMono2
  hi! link jsClassKeywords OneHue3
  hi! link jsClassMethodType OneHue3
  hi! link jsDocParam OneHue2
  hi! link jsDocTags OneHue3
  hi! link jsExport OneHue3
  hi! link jsExportDefault OneHue3
  hi! link jsExtendsKeyword OneHue3
  hi! link jsFrom OneHue3
  hi! link jsFuncBraces OneMono2
  hi! link jsFuncCall OneHue2
  hi! link jsFuncParens OneMono2
  hi! link jsFunction OneHue3
  hi! link jsGenerator OneHue62
  hi! link jsGlobalObjects OneHue62
  hi! link jsImport OneHue3
  hi! link jsModuleWords OneHue3
  hi! link jsModules OneHue3
  hi! link jsModulesAs OneHue3
  hi! link jsNoise OneMono2
  hi! link jsNull OneHue6
  hi! link jsOperator OneHue3
  hi! link jsStorageClass OneHue3
  hi! link jsSuper OneHue5
  hi! link jsParens OneMono2
  hi! link jsStorageClass OneHue3
  hi! link jsTemplateBraces OneHue52
  hi! link jsTemplateVar OneHue4
  hi! link jsThis OneHue5
  hi! link jsUndefined OneHue6
  hi! link jsObjectValue OneHue2
  hi! link jsObjectKey OneHue1
  hi! link jsReturn OneHue3
  " https://github.com/othree/yajs.vim
  hi! link javascriptArrowFunc OneHue3
  hi! link javascriptClassExtends OneHue3
  hi! link javascriptClassKeyword OneHue3
  hi! link javascriptDocNotation OneHue3
  hi! link javascriptDocParamName OneHue2
  hi! link javascriptDocTags OneHue3
  hi! link javascriptEndColons OneMono3
  hi! link javascriptExport OneHue3
  hi! link javascriptFuncArg OneMono1
  hi! link javascriptFuncKeyword OneHue3
  hi! link javascriptIdentifier OneHue5
  hi! link javascriptImport OneHue3
  hi! link javascriptMethodName OneMono1
  hi! link javascriptObjectLabel OneMono1
  hi! link javascriptOpSymbol OneHue1
  hi! link javascriptOpSymbols OneHue1
  hi! link javascriptPropertyName OneHue4
  hi! link javascriptTemplateSB OneHue52
  hi! link javascriptVariable OneHue3
  " }}}

  " JSON highlighting -------------------------------------------------------{{{
  hi! link jsonCommentError OneMono1
  hi! link jsonKeyword OneHue5
  hi! link jsonQuote OneMono3
  call <sid>X('jsonTrailingCommaError',   s:hue_5,   '', 'reverse' )
  call <sid>X('jsonMissingCommaError',    s:hue_5,   '', 'reverse' )
  call <sid>X('jsonNoQuotesError',        s:hue_5,   '', 'reverse' )
  call <sid>X('jsonNumError',             s:hue_5,   '', 'reverse' )
  hi! link jsonString OneHue4
  hi! link jsonBoolean OneHue3
  hi! link jsonNumber OneHue6
  call <sid>X('jsonStringSQError',        s:hue_5,   '', 'reverse' )
  call <sid>X('jsonSemicolonError',       s:hue_5,   '', 'reverse' )
  " }}}

  " LESS highlighting -------------------------------------------------------{{{
  hi! link lessVariable OneHue3
  hi! link lessAmpersandChar OneMono1
  hi! link lessClass OneHue6
  " }}}

  " Markdown highlighting ---------------------------------------------------{{{
  hi! link markdownBlockquote  OneMono3
  call <sid>X('markdownBold',             s:hue_6,   '', 'bold')
  hi! link markdownCode OneHue4
  hi! link markdownCodeBlock OneHue5
  hi! link markdownCodeDelimiter OneHue4
  hi! link markdownH1 OneHue5
  hi! link markdownH2 OneHue5
  hi! link markdownH3 OneHue5
  hi! link markdownH3 OneHue5
  hi! link markdownH4 OneHue5
  hi! link markdownH5 OneHue5
  hi! link markdownH6 OneHue5
  hi! link markdownHeadingDelimiter OneHue52
  hi! link markdownHeadingRule OneMono3
  hi! link markdownId OneHue3
  hi! link markdownIdDeclaration OneHue2
  hi! link markdownIdDelimiter OneHue3
  call <sid>X('markdownItalic',           s:hue_6,   '', 'bold')
  hi! link markdownLinkDelimiter OneHue3
  hi! link markdownLinkText OneHue2
  hi! link markdownListMarker OneHue5
  hi! link markdownOrderedListMarker OneHue5
  hi! link markdownRule OneMono3
  call <sid>X('markdownUrl',           s:hue_1,   '', 'underline')
  " }}}

  " PERL highlighting -------------------------------------------------------{{{
  hi! link perlFiledescRead OneHue4
  hi! link perlFunction OneHue3
  hi! link perlMatchStartEnd OneHue2
  hi! link perlMethod OneHue3
  hi! link perlPOD OneMono3
  hi! link perlSharpBang OneMono3
  hi! link perlSpecialString OneHue1
  hi! link perlStatementFiledesc OneHue5
  hi! link perlStatementFlow OneHue5
  hi! link perlStatementInclude OneHue3
  hi! link perlStatementScalar OneHue3
  hi! link perlStatementStorage OneMono3
  hi! link perlSubName OneHue62
  hi! link perlVarPlain OneHue2
  " }}}

  " PHP highlighting --------------------------------------------------------{{{
  hi! link phpVarSelector OneHue52
  hi! link phpOperator OneMono1
  hi! link phpParent OneMono1
  hi! link phpMemberSelector OneMono1
  hi! link phpType OneHue3
  hi! link phpKeyword OneMono3
  hi! link phpClass OneHue62
  hi! link phpUseClass OneMono1
  hi! link phpUseAlias OneMono1
  hi! link phpInclude OneHue3
  hi! link phpClassExtends OneHue4
  hi! link phpDocTags OneMono1
  hi! link phpFunction OneHue2
  hi! link phpFunctions OneHue1
  hi! link phpMethodsVar OneHue6
  hi! link phpMagicConstants OneHue6
  hi! link phpSuperglobals OneHue5
  hi! link phpConstants OneHue6
  " }}}

  " Pug (Formerly Jade) highlighting ----------------------------------------{{{
  hi! link pugAttributesDelimiter OneHue6
  hi! link pugClass OneHue6
  call <sid>X('pugDocType',               s:mono_3,   '', s:italic)
  hi! link pugTag OneHue5
  " }}}

  " PureScript highlighting -------------------------------------------------{{{
  hi! link purescriptKeyword OneHue3
  hi! link purescriptModuleName OneSyntaxFg
  hi! link purescriptIdentifier OneSyntaxFg
  hi! link purescriptType OneHue62
  hi! link purescriptTypeVar OneHue5
  hi! link purescriptConstructor OneHue5
  hi! link purescriptOperator OneSyntaxFg
  " }}}

  " Python highlighting -----------------------------------------------------{{{
  hi! link pythonImport OneHue3
  hi! link pythonBuiltin OneHue1
  hi! link pythonStatement OneHue3
  hi! link pythonParam OneHue6
  hi! link pythonEscape OneHue5
  call <sid>X('pythonSelf',                 s:mono_2,    '', s:italic)
  hi! link pythonClass OneHue2
  hi! link pythonOperator OneHue3
  hi! link pythonEscape OneHue5
  hi! link pythonFunction OneHue2
  hi! link pythonKeyword OneHue2
  hi! link pythonModule OneHue3
  hi! link pythonStringDelimiter OneHue4
  hi! link pythonSymbol OneHue1
  " }}}

  " Ruby highlighting -------------------------------------------------------{{{
  hi! link rubyBlock OneHue3
  hi! link rubyBlockParameter OneHue5
  hi! link rubyBlockParameterList OneHue5
  hi! link rubyCapitalizedMethod OneHue3
  hi! link rubyClass OneHue3
  hi! link rubyConstant OneHue62
  hi! link rubyControl OneHue3
  hi! link rubyDefine OneHue3
  hi! link rubyEscape OneHue5
  hi! link rubyFunction OneHue2
  hi! link rubyGlobalVariable OneHue5
  hi! link rubyInclude OneHue2
  hi! link rubyIncluderubyGlobalVariable OneHue5
  hi! link rubyInstanceVariable OneHue5
  hi! link rubyInterpolation OneHue1
  hi! link rubyInterpolationDelimiter OneHue5
  hi! link rubyKeyword OneHue2
  hi! link rubyModule OneHue3
  hi! link rubyPseudoVariable OneHue5
  hi! link rubyRegexp OneHue1
  hi! link rubyRegexpDelimiter OneHue1
  hi! link rubyStringDelimiter OneHue4
  hi! link rubySymbol OneHue1
  " }}}

  " Rust highlighting -------------------------------------------------------{{{
  " arzg/vim-rust-syntax-ext
  hi! link rsAs OneMono1
  hi! link rsAttribute OneHue6
  hi! link rsAttributeParenWrapped OneHue4
  hi! link rsAsync OneMono1
  hi! link rsAwait OneMono1
  " hi! link rsBlockComment OneHue4
  hi! link rsBreak OneHue4
  "hi! link rsBoolean OneHue4 " rsTrue & rsFalse can be defined
  " hi! link rsCharacter OneHue4
  " hi! link rsComment OneHue4
  " hi! link rsCommentNote OneHue4
  " hi! link rsConditional OneHue4
  hi! link rsConst OneHue4
  hi! link rsContinue OneHue4
  hi! link rsCrate OneHue52
  hi! link rsCrateConst OneHue52
  hi! link rsCrateFunc OneHue52
  hi! link rsCrateMacro OneHue52
  hi! link rsCrateType OneHue52
  hi! link rsDelimiter OneMono1
  " hi! link rsDocComment OneHue4
  " hi! link rsDocTest OneHue4
  hi! link rsDyn OneHue3
  hi! link rsEnum OneHue4
  hi! link rsExtern OneHue4
  hi! link rsFieldAccess OneHue5
  " hi! link rsFloat OneHue4
  hi! link rsForeignConst OneHue3
  hi! link rsForeignFunc OneHue2
  hi! link rsForeignMacro OneMono1
  hi! link rsForeignType OneHue1
  hi! link rsFn OneHue3
  hi! link rsFuncDef OneHue2
  hi! link rsIdentDef OneMono1
  hi! link rsImpl OneHue3
  hi! link rsIn OneHue3
  hi! link rsInferredLifetime OneHue4
  hi! link rsKeyword OneHue4
  hi! link rsLet OneHue3
  hi! link rsLibraryConst OneHue4
  hi! link rsLibraryFunc OneHue2
  hi! link rsLibraryMacro OneHue2
  hi! link rsLibraryType OneHue62 " OneHue1
  hi! link rsLifetimeDef OneHue62
  hi! link rsMod OneHue3
  hi! link rsModule OneMono1
  hi! link rsMove OneHue3
  hi! link rsMut OneHue3
  " hi! link rsNumber OneHue4
  hi! link rsOperator OneMono1
  hi! link rsPattern OneHue4
  hi! link rsPub OneHue3
  " hi! link rsQuote OneHue4
  hi! link rsRef OneHue4
  " hi! link rsRepeat OneHue4
  hi! link rsReturn OneHue4
  hi! link rsSelfType OneHue1
  hi! link rsSelfValue OneHue5
  hi! link rsSpecialLifetime OneHue4
  hi! link rsStatic OneHue4
  hi! link rsStaticLifetime OneHue4
  " hi! link rsString OneHue4
  hi! link rsStruct OneHue3
  hi! link rsSuper OneHue3
  hi! link rsTrait OneHue3
  hi! link rsTypeAlias OneHue3
  hi! link rsTypeDef OneHue1
  hi! link rsTypeDefParams OneHue4
  hi! link rsTypeParamDef OneHue1
  hi! link rsUnderscore OneHue4
  hi! link rsUnusedFuncDef OneHue4
  hi! link rsUnusedIdentDef OneMono1
  hi! link rsUnusedTypeDef OneHue4
  hi! link rsUnion OneHue4
  hi! link rsUnsafe OneHue4
  hi! link rsUse OneHue3
  hi! link rsUserConst OneHue5
  hi! link rsUserFunc OneHue2
  hi! link rsUserIdent OneMono1
  hi! link rsUserIdentDef OneHue4
  hi! link rsUserLifetime OneHue62
  hi! link rsUserMacro OneHue2
  hi! link rsUserMethod OneHue2
  hi! link rsUserType OneHue1

  " }}}

  " TeX highlighting ------------------------------------------------------{{{
  hi! link texStatement OneHue3
  hi! link texSubscripts OneHue6
  hi! link texSuperscripts OneHue6
  hi! link texTodo OneHue52
  hi! link texBeginEnd OneHue3
  hi! link texBeginEndName OneHue2
  hi! link texMathMatcher OneHue2
  hi! link texMathDelim OneHue2
  hi! link texDelimiter OneHue6
  hi! link texSpecialChar OneHue6
  hi! link texCite OneHue2
  hi! link texRefZone OneHue2
  " }}}

  " TypeScript highlighting ---------------------------------------------------{{{
  hi! link typescriptReserved OneHue3
  hi! link typescriptEndColons OneMono1
  hi! link typescriptBraces OneMono1

  " }}}

  " Spelling highlighting ---------------------------------------------------{{{
  call <sid>X('SpellBad',     '', s:syntax_bg, 'undercurl')
  call <sid>X('SpellLocal',   '', s:syntax_bg, 'undercurl')
  call <sid>X('SpellCap',     '', s:syntax_bg, 'undercurl')
  call <sid>X('SpellRare',    '', s:syntax_bg, 'undercurl')
  " }}}

  " Vim highlighting --------------------------------------------------------{{{
  hi! link vimCommand OneHue3
  call <sid>X('vimCommentTitle', s:mono_3, '', 'bold')
  hi! link vimFunction OneHue1
  hi! link vimFuncName OneHue3
  hi! link vimHighlight OneHue2
  call <sid>X('vimLineComment',  s:mono_3, '', s:italic)
  hi! link vimParenSep OneMono2
  hi! link vimSep OneMono2
  hi! link vimUserFunc OneHue1
  hi! link vimVar OneHue5
  " }}}

  " XML highlighting --------------------------------------------------------{{{
  hi! link xmlAttrib OneHue6
  hi! link xmlEndTag OneHue5
  hi! link xmlTag OneHue5
  hi! link xmlTagName OneHue5
  " }}}

  " ZSH highlighting --------------------------------------------------------{{{
  hi! link zshCommands OneSyntaxFg
  hi! link zshDeref OneHue5
  hi! link zshShortDeref OneHue5
  hi! link zshFunction OneHue1
  hi! link zshKeyword OneHue3
  hi! link zshSubst OneHue5
  hi! link zshSubstDelim OneMono3
  hi! link zshTypes OneHue3
  hi! link zshVariableDef OneHue6
  " }}}

  " man highlighting --------------------------------------------------------{{{
  hi! link manTitle String
  hi! link manFooter OneMono3
  " }}}

  " Plugin Highlighting {{{

  " ALE (Asynchronous Lint Engine) highlighting -----------------------------{{{
  hi! link ALEWarningSign OneHue62
  hi! link ALEErrorSign OneHue5


  " Neovim NERDTree Background fix ------------------------------------------{{{
  hi! link NERDTreeFile OneSyntaxFg
  " }}}

  " easymotion/vim-easymotion -----------------------------------------------{{{
  call <sid>X('EasyMotionTarget',    '', s:hue_5, 'bold')
  call <sid>X('EasyMotionTarget2First',    '', s:hue_6_2, 'bold')
  call <sid>X('EasyMotionTarget2Second',    '', s:hue_6, 'bold')
  hi! link EasyMotionShade OneMono3
  " }}}

  " neomake/neomake ---------------------------------------------------------{{{
  hi! link NeomakeWarningSign OneHue62
  hi! link NeomakeErrorSign OneHue5
  hi! link NeomakeInfoSign OneHue2

  " plasticboy/vim-markdown ---------------------------------------------------{{{
  hi! link mkdDelimiter OneHue3
  hi! link mkdHeading OneHue5
  hi! link mkdLink OneHue2
  call <sid>X('mkdUrl',    '', s:hue_1, 'underline')

  " neoclide/coc.nvim
  hi! link CocCodeLens OneMono2

  "hi! link rsUserType LocalType
  " }}}
  " Neovim Terminal Colors --------------------------------------------------{{{
  let g:terminal_color_0  = "#353a44"
  let g:terminal_color_8  = "#353a44"
  let g:terminal_color_1  = "#e88388"
  let g:terminal_color_9  = "#e88388"
  let g:terminal_color_2  = "#a7cc8c"
  let g:terminal_color_10 = "#a7cc8c"
  let g:terminal_color_3  = "#ebca8d"
  let g:terminal_color_11 = "#ebca8d"
  let g:terminal_color_4  = "#72bef2"
  let g:terminal_color_12 = "#72bef2"
  let g:terminal_color_5  = "#d291e4"
  let g:terminal_color_13 = "#d291e4"
  let g:terminal_color_6  = "#65c2cd"
  let g:terminal_color_14 = "#65c2cd"
  let g:terminal_color_7  = "#e3e5e9"
  let g:terminal_color_15 = "#e3e5e9"

  " Delete functions =========================================================={{{
  " delf <SID>X
  " delf <SID>XAPI
  " delf <SID>rgb
  " delf <SID>color
  " delf <SID>rgb_color
  " delf <SID>rgb_level
  " delf <SID>rgb_number
  " delf <SID>grey_color
  " delf <SID>grey_level
  " delf <SID>grey_number
  " delf <SID>user_color_palette
  " }}}

endif
"}}}
" Termdebug highlighting for Vim 8.1+ --------------------------------------{{{
" See `:h hl-debugPC` and `:h hl-debugBreakpoint`.
  call <sid>X('debugPC',          '',    s:special_grey, '') " the current position
  call <sid>X('VertSplit',    s:vertsplit,     s:hue_5,               '') " a breakpoint
" }}}

" Public API --------------------------------------------------------------{{{
function! one#highlight(group, fg, bg, attr)
  call <sid>XAPI(a:group, a:fg, a:bg, a:attr)
endfunction
"}}}

if exists('s:dark') && s:dark
  set background=dark
endif

" vim: set fdl=0 fdm=marker:
