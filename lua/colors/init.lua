-- Name:         Space-nvim theme
-- Description:  Light and dark theme inspired by spacemacs-theme
-- Author:       Th3Whit3Wolf <the.white.wolf.is.1337@gmail.com>
-- Maintainer:   Th3Whit3Wolf <the.white.wolf.is.1337@gmail.com>
-- Website:      
-- License:      Vim License (see `:help license`)

vim.cmd('packadd colorbuddy.nvim')
local Color, colors, Group, groups, styles = require('colorbuddy').setup()

if vim.o.background ==# 'dark' then
    -- Dark Colors
    Color.new('bg0', "#292b2e")
    Color.new('bg1', "#212026")
    Color.new('bg2', "#100a14")
    Color.new('bg3', "#0a0814")
    Color.new('bg4', "#34323e")
    Color.new('fg0', "#cdcdcd")
    Color.new('fg1', "#b2b2b2")
    Color.new('fg2', "#8e8e8e")
    Color.new('fg3', "#727272")
    Color.new('fg4', "#5b5b5b")
    Color.new('fg5', "#9a9aba")
    Color.new('fg6', "#5e5079")
    Color.new('fg7', "#666666")
    Color.new('grey', "#44505c")
    Color.new('grey1', "#768294")
    Color.new('red1', "#ce537a")
    Color.new('blue1', "#7590db")
    Color.new('purple0',"#bc6ec5")
    Color.new('purple1', "#d698fe")
    Color.new('purple2', "#a45bad")
    Color.new('purple3', "#5d4d7a")
    Color.new('purple4', "#34323e")
    Color.new('aqua0', "#2d9574")
    Color.new('orange0', "#e18254")
    Color.new('cyan', "#28def0")
    Color.new('mat', "#86dc2f")
    Color.new('meta', "#9f8766")
    Color.new('highlight', "#444155")
    Color.new('comp', "#c56ec3")
    Color.new('cblk', "#cbc1d5")
    -- Terminal Colors
    vim.g.terminal_color_0  = '#292b2e'
    vim.g.terminal_color_8  = '#44505c'
    vim.g.terminal_color_12 = '#4f97d7'
    vim.g.terminal_color_13 = '#bc6ec5'
    vim.g.terminal_color_14 = '#2d9574'
    vim.g.terminal_color_7  = '#5b5b5b'
    vim.g.terminal_color_15 = '#b2b2b2'
else
    -- Light Colors
    Color.new('bg0', "#fbf8ef")
    Color.new('bg1', "#efeae9")
    Color.new('bg2', "#e3dedd")
    Color.new('bg3', "#d2ceda")
    Color.new('bg4', "#a8a4ae")
    Color.new('fg0', "#83758c")
    Color.new('fg1', "#655370")
    Color.new('fg2', "#5a4a64")
    Color.new('fg3', "#504259")
    Color.new('fg4', "#463a4e")
    Color.new('fg5', "#8c799f")
    Color.new('fg6', "#c8c6dd")
    --Color.new('fg7', "#666666")
    Color.new('grey', "#a8a8bf")
    Color.new('grey1', "#768294")
    Color.new('red1', "#ba2f59")
    Color.new('blue1', "#715ab1")
    Color.new('purple0',"#6c3163")
    Color.new('purple1', "#86589e")
    Color.new('purple2', "#4e3163")
    Color.new('purple3', "#d3d3e7")
    Color.new('purple4', "#e2e0ea")
    Color.new('aqua0', "#24775c")
    Color.new('orange0', "#b46843")
    Color.new('cyan', "#21b8c7")
    Color.new('mat', "#ba2f59")
    Color.new('meta', "#da8b55")
    Color.new('highlight', "#d3d3e7")
    Color.new('comp', "#6c4173")
    Color.new('cblk', "#655370")
    -- Terminal Colors
    vim.g.terminal_color_0  = '#fbf8ef'
    vim.g.terminal_color_8  = '#a8a8bf'
    vim.g.terminal_color_12 = '#3a81c3'
    vim.g.terminal_color_13 = '#6c3163'
    vim.g.terminal_color_14 = '#24775c'
    vim.g.terminal_color_7  = '#463a4e'
    vim.g.terminal_color_15 = '#655370'
end

-- Common Colors
Color.new('red', "#f2241f")
Color.new('red0', "#f54e3c")
Color.new('blue', "#58b0d9")
Color.new('blue0', "#4f97d7")
Color.new('purple', "#544a65")
Color.new('green', "#67b11d")
Color.new('green0', "#2aa1ae")
Color.new('aqua', "#4495b4")
Color.new('orange', "#d79650")
Color.new('yellow', "#b1951d")
Color.new('yellow1', "#e5d11c")
Color.new('war', "#dc752f")
Color.new('number', "#e697e6")
Color.new('debug', "#ffc8c8")
Color.new('float', "#b7b7ff")
Color.new('delimiter', "#74baac")

-- Common Terminal Colors
vim.g.terminal_color_1  = '#d26487'
vim.g.terminal_color_2  = '#35a8a5'
vim.g.terminal_color_3  = '#b89f33'
vim.g.terminal_color_4  = '#6981c5'
vim.g.terminal_color_5  = '#a15ea7'
vim.g.terminal_color_6  = '#288668'
vim.g.terminal_color_9  = '#f2241f'
vim.g.terminal_color_10 = '#67b11d'
vim.g.terminal_color_11 = '#b1951d'

-- Syntax Groups (descriptions and ordering from `:h w18`)
Group.new('Comment',        colors.green0,  nil, styles.italic) -- any comment
Group.new('Constant',       colors.green0,  nil, nil) -- any constant
Group.new('String',         colors.aqua0,   nil, styles.italic) -- this is a string
Group.new('Character',      colors.purple0, nil, nil) -- a character constant: 'c', '\n'
Group.new('Boolean',        colors.war,     nil, nil) -- a boolean constant: TRUE, false
Group.new('Float',          colors.float,   nil, nil) -- a floating point constant: 2.3e10
Group.new('Identifier',     colors.blue1,   nil, nil) -- any variable name
Group.new('Function',       colors.purple0, nil, nil) -- function name (also: methods for classes)
Group.new('Statement',      colors.blue0,   nil, nil) -- any statement
Group.new('Conditional',    colors.blue0,   nil, styles.bold) -- if, then, else, endif, switch, etc.
Group.new('Repeat',         colors.red1,    nil, styles.bold) -- for, do, while, etc.
Group.new('Label',          colors.red1,    nil, nil) -- case, default, etc.
Group.new('Operator',       colors.blue,    nil, nil) -- sizeof", "+", "*", etc.
Group.new('Keyword',        colors.blue0,   nil, styles.bold) -- any other keyword
Group.new('Exception',      colors.red,     nil, nil) -- try, catch, throw
Group.new('PreProc',        colors.purple1, nil, nil) -- generic Preprocessor
Group.new('Include',        colors.yellow,  nil, nil) -- preprocessor #include
Group.new('Define',         colors.aqua0,   nil, nil) -- preprocessor #define
Group.new('Macro',          colors.blue1,   nil, styles.bold) -- same as Define
Group.new('PreCondit',      colors.purple2, nil, nil) -- preprocessor #if, #else, #endif, etc.
Group.new('Type',           colors.red1,    nil, nil) -- int, long, char, etc.

Group.new('StorageClass',   colors.float,   nil, nil) -- static, register, volatile, etc.
Group.new('Structure',      colors.float,   nil, nil) -- struct, union, enum, etc.
Group.new('Typedef',        colors.float,   nil, nil) -- A typedef
Group.new('Special',        colors.float,   nil, styles.italic) -- any special symbol
Group.new('SpecialChar',    colors.float,   nil, nil) -- special character in a constant
Group.new('Tag',            colors.float,   nil, nil) -- you can use CTRL-] on this
Group.new('Delimiter',      colors.float,   nil, nil) -- character that needs attention
Group.new('SpecialComment', colors.float,   nil, nil) -- special things inside a comment
Group.new('Debug',          colors.float,   nil, nil) -- debugging statementse
Group.new('Underlined',     colors.float,   nil, nil) -- text that stands out, HTML links
Group.new('Ignore',         colors.float,   nil, nil) -- left blank, hidden
Group.new('Error',          colors.float,   nil, nil) -- any erroneous construct
Group.new('Todo',           colors.float,   nil, styles.italic) -- anything that needs extra attention; mostly the keywords TODO FIXME and XXX

-- Highlighting Groups (descriptions and ordering from `:h highlight-groups`)
-- call s:h("ColorColumn", { "bg": s:cursor_grey }) " used for the columns set with 'colorcolumn'
-- call s:h("Conceal", {}) " placeholder characters substituted for concealed text (see 'conceallevel')
-- call s:h("Cursor", { "fg": s:black, "bg": s:blue }) " the character under the cursor
-- call s:h("CursorIM", {}) " like Cursor, but used when in IME mode
-- call s:h("CursorColumn", { "bg": s:cursor_grey }) " the screen column that the cursor is in when 'cursorcolumn' is set
-- if &diff
--  " Don't change the background color in diff mode
  -- call s:h("CursorLine", { "gui": "underline" }) " the screen line that the cursor is in when 'cursorline' is set
-- else
  -- call s:h("CursorLine", { "bg": s:cursor_grey }) " the screen line that the cursor is in when 'cursorline' is set
-- endif
-- call s:h("Directory", { "fg": s:blue }) " directory names (and other special names in listings)
-- call s:h("DiffAdd", { "bg": s:green, "fg": s:black }) " diff mode: Added line
-- call s:h("DiffChange", { "fg": s:yellow, "gui": "underline", "cterm": "underline" }) " diff mode: Changed line
-- call s:h("DiffDelete", { "bg": s:red, "fg": s:black }) " diff mode: Deleted line
-- call s:h("DiffText", { "bg": s:yellow, "fg": s:black }) " diff mode: Changed text within a changed line

-- If enabled, will style end-of-buffer filler lines (~) to appear to be hidden.
-- call s:h("EndOfBuffer", { "fg": s:black }) " filler lines (~) after the last line in the buffer

-- call s:h("ErrorMsg", { "fg": s:red }) " error messages on the command line
-- call s:h("VertSplit", { "fg": s:vertsplit }) " the column separating verti-- cally split windows
-- call s:h("Folded", { "fg": s:comment_grey }) " line used for closed folds
-- call s:h("FoldColumn", {}) " 'foldcolumn'
-- call s:h("SignColumn", {}) " column where signs are displayed
-- call s:h("IncSearch", { "fg": s:yellow, "bg": s:comment_grey }) " 'incsearch' highlighting; also used for the text replaced with ":s///c"
-- call s:h("LineNr", { "fg": s:gutter_fg_grey }) " Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
-- call s:h("CursorLineNr", {}) " Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
-- call s:h("MatchParen", { "fg": s:blue, "gui": "underline", "cterm": "underline" }) " The character under the cursor or just before it, if it is a paired bracket, and its match.
-- call s:h("ModeMsg", {}) " 'showmode' message (e.g., "-- INSERT --")
-- call s:h("MoreMsg", {}) " more-prompt
-- call s:h("NonText", { "fg": s:special_grey }) " '~' and '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line).
-- call s:h("Normal", { "fg": s:white, "bg": s:black }) " normal text
-- call s:h("Pmenu", { "bg": s:menu_grey }) " Popup menu: normal item.
-- call s:h("PmenuSel", { "fg": s:black, "bg": s:blue }) " Popup menu: selected item.
-- call s:h("PmenuSbar", { "bg": s:special_grey }) " Popup menu: scrollbar.
-- call s:h("PmenuThumb", { "bg": s:white }) " Popup menu: Thumb of the scrollbar.
-- call s:h("Question", { "fg": s:purple }) " hit-enter prompt and yes/no questions
-- call s:h("QuickFixLine", { "fg": s:black, "bg": s:yellow }) " Current quickfix item in the quickfix window.
-- call s:h("Search", { "fg": s:black, "bg": s:yellow }) " Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
-- call s:h("SpecialKey", { "fg": s:special_grey }) " Meta and special keys listed with ":map", also for text used to show unprintable characters in the text, 'listchars'. Generally: text that is displayed differently from what it really is.
-- call s:h("SpellBad", { "fg": s:red, "gui": "underline", "cterm": "underline" }) " Word that is not recognized by the spellchecker. This will be combined with the highlighting used otherwise.
-- call s:h("SpellCap", { "fg": s:dark_yellow }) " Word that should start with a capital. This will be combined with the highlighting used otherwise.
-- call s:h("SpellLocal", { "fg": s:dark_yellow }) " Word that is recognized by the spellchecker as one that is used in another region. This will be combined with the highlighting used otherwise.
-- call s:h("SpellRare", { "fg": s:dark_yellow }) " Word that is recognized by the spellchecker as one that is hardly ever used. spell This will be combined with the highlighting used otherwise.
-- call s:h("StatusLine", { "fg": s:white, "bg": s:cursor_grey }) " status line of current window
-- call s:h("StatusLineNC", { "fg": s:comment_grey }) " status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
-- call s:h("StatusLineTerm", { "fg": s:white, "bg": s:cursor_grey }) " status line of current :terminal window
-- call s:h("StatusLineTermNC", { "fg": s:comment_grey }) " status line of non-current :terminal window
Group.new('TabLineFill',         colors.purple, nil, nil)
Group.new('TabLineSel',          colors.fg,     nil, nil)
Group.new('TabLine',             colors.purple, nil, nil)
-- call s:h("Terminal", { "fg": s:white, "bg": s:black }) " terminal window (see terminal-size-color)
-- call s:h("Title", { "fg": s:green }) " titles for output from ":set all", ":autocmd" etc.
-- call s:h("Visual", { "fg": s:visual_black, "bg": s:visual_grey }) " Visual mode selection
-- call s:h("VisualNOS", { "bg": s:visual_grey }) " Visual mode selection when vim is "Not Owning the Selection". Only X11 Gui's gui-x11 and xterm-clipboard supports this.
-- call s:h("WarningMsg", { "fg": s:yellow }) " warning messages
-- call s:h("WildMenu", { "fg": s:black, "bg": s:blue }) " current match in 'wildmenu' completion

-- Language-Specific Highlighting

-- CSS

-- Fish

-- Go

-- HTML (keep consistent with Markdown, below)

-- JavaScript

-- JSON

-- LESS

-- Markdown (keep consistent with HTML, above

-- Perl

-- PHP

-- Ruby

-- Rust
Group.new('rustSelf',   colors.blue0, nil, styles.bold)
Group.new('rustPanic',  colors.red1,  nil, styles.bold)
Group.new('rustAssert', colors.blue1, nil, styles.bold)

-- Sass

-- TeX

-- TypeScript

-- XML

-- Plugin Highlighting

-- Git Highlighting

-- +- Neovim Support -+
-- Group.new("healthError",colors.nord_11, colors.nord_1)
-- Group.new("healthSuccess",colors.nord_14, colors.nord_1)
-- Group.new("healthWarning",colors.nord_13, colors.nord_1)
-- Group.new("TermCursorNC",colors.nord_1, colors.nord_1)
-- Group.new("IncSearch",colors.nord_6, colors.nord_10, styles.underline)
-- Group.new("Search",colors.nord_1, colors.nord_8)

-- LSP Groups (descriptions and ordering from `:h lsp-highlight`)
-- Group.new("LspDiagnosticsError", colors.nord_11, colors.none) -- used for "Error" diagnostic virtual text
-- Group.new("LspDiagnosticsErrorSign", colors.nord_11, colors.none) -- used for "Error" diagnostic signs in sign column
-- Group.new("LspDiagnosticsErrorFloating", colors.nord_11, colors.none) -- used for "Error" diagnostic messages in the diagnostics float
-- Group.new("LspDiagnosticsWarning", colors.nord_11, colors.none) -- used for "Warning" diagnostic virtual text
-- Group.new("LspDiagnosticsWarningSign", colors.nord_13, colors.none) -- used for "Warning" diagnostic signs in sign column
-- Group.new("LspDiagnosticsWarningFloating", colors.nord_8, colors.none) -- used for "Warning" diagnostic messages in the diagnostics float
-- Group.new("LSPDiagnosticsInformation", colors.nord_10, colors.none) -- used for "Information" diagnostic virtual text
-- Group.new("LspDiagnosticsInformationSign", colors.nord_8, colors.none)  -- used for "Information" diagnostic signs in sign column
-- Group.new("LspDiagnosticsInformationFloating", colors.nord_10, colors.none) -- used for "Information" diagnostic messages in the diagnostics float
-- Group.new("LspDiagnosticsHint", colors.nord_8, colors.none)  -- used for "Hint" diagnostic virtual text
-- Group.new("LspDiagnosticsHintSign", colors.nord_10, colors.none) -- used for "Hint" diagnostic signs in sign column
-- Group.new("LspDiagnosticsHintFloating", colors.nord_8, colors.none) -- used for "Hint" diagnostic messages in the diagnostics float
-- Group.new("LspReferenceText", colors.nord_10, colors.none) -- used for highlighting "text" references
-- Group.new("LspReferenceRead", colors.nord_10, colors.none) -- used for highlighting "read" references
-- Group.new("LspReferenceWrite", colors.nord_10, colors.none) -- used for highlighting "write" references


-- Nvim Treesitter Groups (descriptions and ordering from `:h nvim-treesitter-highlights`)
Group.new("TSError"              , groups.Error     , nil , styles.bold) -- For syntax/parser errors
Group.new("TSPunctDelimiter"     , colors.Delimiter , nil) -- For delimiters ie: `.
-- Group.new("TSPunctBracket"       , colors.fg     , nil) -- For brackets and parens
-- Group.new("TSPunctSpecial"       , colors.fg     , nil) -- For special punctutation that does not fall in the catagories before
Group.new("TSConstant"           , groups.Constant  , nil) -- For constants
Group.new("TSConstBuiltin"       , groups.Constant  , nil) -- For constant that are built in the language: `nil` in Lua
Group.new("TSConstMacro"         , groups.Constant  , nil) -- For constants that are defined by macros: `NULL` in C
Group.new("TSString"             , groups.String    , nil) -- For strings
-- Group.new("TSStringRegex"        , colors.fg_escape_char_construct , nil) -- For regexes
-- Group.new("TSStringEscape"       , colors.fg_escape_char_backslash , nil) -- For escape characters within a string
Group.new("TSCharacter"          , groups.Character  , nil) -- For characters
Group.new("TSNumber"             , groups.Number     , nil) -- For integers
Group.new("TSBoolean"            , groups.Boolean    , nil) -- For booleans
Group.new("TSFloat"              , groups.Float      , nil) -- For floats
Group.new("TSFunction"           , groups.Function   , nil) -- For function (calls and definitions
Group.new("TSFuncBuiltin"        , groups.Function   , nil) -- For builtin functions: `table.insert` in Lua
Group.new("TSFuncMacro"          , groups.Function   , nil) -- For macro defined fuctions (calls and definitions): each `macro_rules` in Rust.
-- Group.new("TSParameter"          , colors.cyan              , colors.none  , styles.none) -- For parameters of a function.
-- Group.new("TSParameterReference" , groups.TSParameter     , nil) -- For references to parameters of a function.
Group.new("TSMethod"             , groups.Function        , nil) -- For method calls and definitions.
-- Group.new("TSField"    , colors.magenta_alt_other , colors.none  , styles.none) -- For fields.
-- Group.new("TSProperty"    , TSField , colors.none  , styles.none) -- Same as `TSField`.
-- Group.new("TSConstructor"        , colors.magenta_alt       , colors.none)  -- For constructor calls and definitions: `{}` in Lua, and Java constructors
Group.new("TSConditional"        , groups.Conditional     , nil) -- For keywords related to conditionnals
Group.new("TSRepeat"             , groups.Repeat          , nil) -- For keywords related to loops
Group.new("TSLabel"              , groups.Label           , nil) -- For labels: `label:` in C and `:label:` in Lua
Group.new("TSOperator"           , groups.Operator        , nil) -- For any operator: `+`, but also `->` and `*` in C
Group.new("TSKeyword"            , groups.Keyword         , nil) -- For keywords that don't fall in previous categories.
-- Group.new("TSKeywordFunction"    , colors.magenta_alt       , colors.none  , styles.none) -- For keywords used to define a fuction.
Group.new("TSException"          , groups.Exception       , nil) -- For exception related keywords.
Group.new("TSType"               , groups.Type            , nil , styles.none) -- For types.
Group.new("TSTypeBuiltin"        , groups.Type            , nil , styles.none) -- For builtin types (you guessed it, right ?).
Group.new("TSStructure"          , groups.Structure       , nil) -- This is left as an exercise for the reader.
Group.new("TSInclude"            , groups.Include         , nil) -- For includes: `#include` in C, `use` or `extern crate` in Rust, or `require` in Lua.
-- Group.new("TSAnnotation"         , colors.blue_nuanced_bg , colors.none) -- For C++/Dart attributes, annotations that can be attached to the code to denote some kind of meta information.
-- Group.new("TSText"             , colors.fg              , colors.bg           , styles.bold) -- For strings considered text in a markup language.
-- Group.new("TSStrong"             , colors.fg              , colors.bg           , styles.bold) -- For text to be represented with strong.
-- Group.new("TSEmphasis"            , colors.blue_alt          , colors.none  , styles.bold) -- For text to be represented with emphasis.
-- Group.new("TSUnderline"            , colors.blue_alt          , colors.none  , styles.bold) -- TSUnderline
-- Group.new("TSTitle"              , colors.cyan_nuanced    , colors.none) -- Text that is part of a title.
-- Group.new("TSLiteral"            , colors.blue_alt          , colors.none  , styles.bold) -- Literal text.
-- Group.new("TSURI"           , colors.cyan              , colors.none  , styles.none) -- Any URI like a link or email.
-- Group.new("TSVariable"           , colors.cyan              , colors.none  , styles.none) -- Any URI like a link or email.
-- Group.new("TSVariableBuiltin" , groups.magenta_alt_other     , nil) -- Variable names that are defined by the languages, like `this` or `self`.

