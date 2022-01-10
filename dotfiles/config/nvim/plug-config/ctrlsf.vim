""""""""""""
"  ctrlsf  "
""""""""""""

let g:ctrlsf_ackprg = 'rg'
let g:ctrlsf_default_root = 'project+fw'
let g:ctrlsf_default_view_mode = 'compact'
let g:ctrlsf_follow_symlinks = 0

let g:ctrlsf_auto_focus = {
    \ 'at' : 'start',
    \ 'duration_less_than': 1000
    \ }

"Input :CtrlSF in command line for you
nmap     <a-f>f <plug>CtrlSFPrompt
nmap     <a-f><a-f> <plug>CtrlSFPrompt

"Prepare to search visual selected word
vmap     <a-f>f <plug>CtrlSFVwordPath
vmap     <a-f><a-f> <plug>CtrlSFVwordExec
"Immediately search visual selected word
"vmap     <a-f><a-f> <plug>CtrlSFVwordExec

"Search the word under cursor, don't pass argument to CtrlSFprompt will do the same
"nmap     <c-f>g <plug>CtrlSFCwordPath
"nmap     <c-f><c-g> <plug>CtrlSFCwordExec

"Prepare to search the word under cursor and add boundary to it
nmap     <a-f>b <plug>CtrlSFCCwordPath
nmap     <a-f><a-b> <plug>CtrlSFCCwordExec

"Not working, don't know why
"nmap     <c-f>p <plug>CtrlSFPwordPath
"nmap     <c-f><c-p> <plug>CtrlSFPwordExec
nnoremap <a-f>t :CtrlSFToggle<cr>
nnoremap <a-f><a-t> :CtrlSFToggle<cr>
