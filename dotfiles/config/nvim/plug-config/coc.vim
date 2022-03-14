let g:coc_global_extensions = [
      \'coc-markdownlint',
      \'coc-highlight',
      \'coc-html',
      \'coc-jedi',
      \'coc-tsserver',
      \'coc-css',
      \'coc-json',
      \'coc-snippets',
      \'coc-prettier',
      \'coc-pydocstring',
      \'coc-marketplace',
      \]

" Explorer
let g:coc_explorer_global_presets = {
\   '.vim': {
\     'root-uri': '~/.vim',
\   },
\   'tab': {
\     'position': 'tab',
\     'quit-on-open': v:true,
\   },
\   'floating': {
\     'position': 'floating',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingTop': {
\     'position': 'floating',
\     'floating-position': 'center-top',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingLeftside': {
\     'position': 'floating',
\     'floating-position': 'left-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingRightside': {
\     'position': 'floating',
\     'floating-position': 'right-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'simplify': {
\     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   }
\ }

nmap <leader>e :CocCommand explorer<CR>
" nmap <space>f :CocCommand explorer --preset floating<CR>
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif

" set rootPatterns for python porject
autocmd FileType python let b:coc_root_patterns = ['.git', '.env']

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>


" Remap for format selected region
vmap <Space>cf  <Plug>(coc-format-selected)
nmap <Space>cf  <Plug>(coc-format-selected)
" Show all diagnostics
nnoremap <silent> <Space>ca  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <Space>ce  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <Space>cc  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <Space>co  :<C-u>CocList outline<cr>
" Search workleader symbols
nnoremap <silent> <Space>cs  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <Space>cj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <Space>ck  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <Space>cl  :<C-u>CocListResume<CR>

" Remap for rename current word
nmap <silent> <Space>rn <Plug>(coc-rename)

" coc prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
nnoremap <silent> <Space>bf :<C-u>call CocAction()<CR>

