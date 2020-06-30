"""""""""""""""""""""""""""""
" Install Coc Extenstions
"""""""""""""""""""""""""""""
let g:coc_global_extensions = [
	\ 'coc-tag',
	\ 'coc-word',
	\ 'coc-utils',
	\ 'coc-marketplace',
	\ 'coc-diagnostic',
	\ 'coc-git',
	\ 'coc-snippets',
	\ 'coc-yank',
	\ 'coc-highlight',
	\ 'coc-explorer',
	\ 'coc-python',
	\ 'coc-pairs',
	\ 'coc-markdownlint',
	\ 'coc-sh',
	\ 'coc-emmet',
	\ 'coc-html',
	\ 'coc-json',
	\ 'coc-css',
	\ 'coc-yaml',
	\ 'coc-svg',
	\ 'coc-vimlsp',
	\ 'coc-eslint',
	\ 'coc-actions',
	\ 'coc-tasks',
	\ 'coc-browser',
	\ 'coc-rust-analyzer',
	\ 'coc-tsserver'
	\]

if executable('clangd')
	let g:coc_global_extensions += ['coc-clangd']
endif
if executable('docker')
	let g:coc_global_extensions += ['coc-docker']
endif
if executable('elixir') && executable('mix')
	let g:coc_global_extensions += ['coc-elixir']
endif
if executable('erlang_ls')
	let g:coc_global_extensions += ['coc-erlang_ls']
endif
if executable('flutter')
	let g:coc_global_extensions += ['coc-flutter']
endif
if executable('gopls')
	let g:coc_global_extensions += ['coc-go']
endif
if executable('php')
	let g:coc_global_extensions += ['coc-phpls']
endif
if executable('r')
	let g:coc_global_extensions += ['coc-r-lsp']
endif
if executable('ruby')
	let g:coc_global_extensions += ['coc-solargraph']
endif
if executable('texlab')
	let g:coc_global_extensions += ['coc-texlab']
endif
if executable('vls')
	let g:coc_global_extensions += ['coc-vetur']
endif

function! CheckBackSpace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! ShowDocumentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

function! UninstallUnusedCocExtensions() abort
    for e in keys(json_decode(join(readfile(expand('~/.config/coc/extensions/package.json')), "\n"))['dependencies'])
        if index(s:coc_extensions, e) < 0
            execute 'CocUninstall ' . e
        endif
    endfor
endfunction

augroup cocNvim
	autocmd!
	" Setup formatexpr specified filetype(s).
	autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
	" Update signature help on jump placeholder.
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
	" Remove unused coc extension
	autocmd User CocNvimInit call UninstallUnusedCocExtensions()
augroup end

let g:coc_snippet_next = '<tab>'

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use <C-j> and <C-k> to navigate the completion list:
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" Close the preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

inoremap <silent><expr> <TAB>
	\ complete_info()["selected"] != "-1" ? coc#_select_confirm() :
	\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
	\ CheckBackSpace() ? "\<TAB>" :
	\ coc#refresh()


""" Conqueror of Code """

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>cas  <Plug>(coc-codeaction-selected)
nmap <leader>cas  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ca <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>cqf <Plug>(coc-fix-current)

" Symbol renaming.
nmap <leader>crn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>cf  <Plug>(coc-format-selected)
nmap <leader>cf  <Plug>(coc-format-selected)

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>cld  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <leader>cle  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <leader>clc  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <leader>clo  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <leader>cls  :<C-u>CocList -I symbols<cr>
" Resume latest coc list.
nnoremap <silent><nowait> <leader>clr  :<C-u>CocListResume<CR>
" Do default action for next item.
nnoremap <silent><nowait> <leader>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <leader>k  :<C-u>CocPrev<CR>



" Insert Indented new line after pressing enter after closing pair
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-d for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

nmap <leader>cla <Plug>(coc-codelens-action)