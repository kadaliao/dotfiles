"""""""""""
"  ctrlP  "
"""""""""""

nmap <leader>ji :CtrlPBufTagAll<cr>
nmap <leader>jt :CtrlPTag<cr>
nmap <leader>ff :CtrlPCurFile<cr>

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/tags     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows


let g:ctrlp_match_window = 'results:30'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](node_modules|target|dist|venv|env)|(\.(swp|ico|git|svn|env|venv))$',
  \ 'file': '\v(tags)|\.(exe|so|dll|pyc)$',
  \ }
let g:ctrlp_use_caching = 0
