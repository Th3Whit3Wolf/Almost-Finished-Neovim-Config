" =============================================================================
" Filename: spaceline.vim
" Author: taigacute
" URL: https://github.com/taigacute/spaceline.vim
" License: MIT License
" =============================================================================

scriptencoding utf-8
if exists('g:loaded_spaceline') || v:version < 700
  finish
endif

let g:loaded_spaceline = 1

let g:symbol = get(g:, 'spaceline_line_symbol', 0)
let g:seperate_style = get(g:, 'spaceline_seperate_style', 'slant')
let g:spaceline_colorscheme = get(g:, 'spaceline_colorscheme', 'one')
let g:spaceline_shortline_filetype = ['defx','coc-explorer','dbui','vista','vista_markdown','Mundo','MundoDiff']
let g:spaceline_scroll_bar_chars = get(g:,'spaceline_scroll_bar_chars', [
  \  '▁', '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█'
  \  ])
let g:spaceline_lsp = get(g:,'spaceline_lsp_executive','coc')
let g:spaceline_git = get(g:,'spaceline_git_tool','coc')
let g:spaceline_git_branch_icon = get(g:,'spaceline_git_branch_icon','')
let g:sep= {}
let g:sep = spaceline#seperator#spacelineStyle(g:seperate_style)

augroup spaceline
  autocmd!
  autocmd FileType,WinEnter,BufWinEnter,BufReadPost,BufWritePost * call spaceline#spacelinetoggle()
  autocmd Colorscheme * call spaceline#colorscheme_init()
  autocmd VimResized * call spaceline#spacelinetoggle()
  autocmd WinLeave * call spaceline#setInActiveStatusLine()
  autocmd User CocStatusChange,CocGitStatusChange,ClapOnExit call spaceline#spacelinetoggle()
  autocmd User CocDiagnosticChange call spaceline#spacelinetoggle()
augroup END "}}}
