let b:AutoPairs = AutoPairsDefine({'\w\zs<': '>'})

setlocal makeprg=cargo\ build

setlocal errorformat+=
			\%-G,
			\%-Gerror:\ aborting\ %.%#,
			\%-Gerror:\ Could\ not\ compile\ %.%#,
			\%Eerror:\ %m,
			\%Eerror[E%n]:\ %m,
			\%Wwarning:\ %m,
			\%Inote:\ %m,
			\%C\ %#-->\ %f:%l:%c

function s:rustdoclsphilight()
	if &background ==# 'dark'
		let l:color = '#5d4d7a'
	else
		let l:color = '#e2e0ea'
	endif
	exec 'hi markdownRustStructure guibg='.l:color
	exec 'hi markdownRustKeyword guibg='.l:color
	exec 'hi markdownRustAwait guibg='.l:color
	exec 'hi markdownrustIdentifier guibg='.l:color
	exec 'hi markdownItalic guibg='.l:color
	exec 'hi markdownAutomaticLink guibg='.l:color
	exec 'hi markdownBlockquote guibg='.l:color
	exec 'hi markdownBold guibg='.l:color
	exec 'hi markdownBoldDelimiter guibg='.l:color
	exec 'hi markdownBoldItalic guibg='.l:color
	exec 'hi markdownBoldItalicDelimiter guibg='.l:color
	exec 'hi markdownCode guibg='.l:color
	exec 'hi markdownCodeBlock guibg='.l:color
	exec 'hi markdownCodeDelimiter guibg='.l:color
	exec 'hi markdownError guibg='.l:color
	exec 'hi markdownEscape guibg='.l:color
	exec 'hi markdownFootnote guibg='.l:color
	exec 'hi markdownFootnoteDefinition guibg='.l:color
	exec 'hi markdownH1 guibg='.l:color
	exec 'hi markdownH2 guibg='.l:color
	exec 'hi markdownH3 guibg='.l:color
	exec 'hi markdownH4 guibg='.l:color
	exec 'hi markdownH5 guibg='.l:color
	exec 'hi markdownH6 guibg='.l:color
	exec 'hi markdownHeadingDelimiter guibg='.l:color
	exec 'hi markdownHeadingRule guibg='.l:color
	exec 'hi markdownId guibg='.l:color
	exec 'hi markdownIdDeclaration guibg='.l:color
	exec 'hi markdownIdDelimiter guibg='.l:color
	exec 'hi markdownItalic guibg='.l:color
	exec 'hi markdownItalicDelimiter guibg='.l:color
	exec 'hi markdownLineBreak guibg='.l:color
	exec 'hi markdownLineStart guibg='.l:color
	exec 'hi markdownLink guibg='.l:color
	exec 'hi markdownLinkDelimiter guibg='.l:color
	exec 'hi markdownLinkText guibg='.l:color
	exec 'hi markdownLinkTextDelimiter guibg='.l:color
	exec 'hi markdownListMarker guibg='.l:color
	exec 'hi markdownOrderedListMarker guibg='.l:color
	exec 'hi markdownRule guibg='.l:color
	exec 'hi markdownUrl guibg='.l:color
	exec 'hi markdownUrlDelimiter guibg='.l:color
	exec 'hi markdownUrlTitle guibg='.l:color
	exec 'hi markdownUrlTitleDelimiter guibg='.l:color
	exec 'hi markdownUrlValid guibg='.l:color
endfunction!

call <SID>rustdoclsphilight()

