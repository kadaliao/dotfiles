" Map leader to which_key
nnoremap <silent> <leader> :silent WhichKey '<leader>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<leader>'<CR>
nnoremap <silent> <leader> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

" Create map to add keys to
let g:which_key_map =  {}
" Define a separator
let g:which_key_sep = '→'
" set timeoutlen=100

" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0

" Change the colors if you want
highlight default link WhichKey          Operator
highlight default link WhichKeySeperator DiffAdded
highlight default link WhichKeyGroup     Identifier
highlight default link WhichKeyDesc      Function

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

" Single mappings
" let g:which_key_map['/'] = [ '<Plug>NERDCommenterToggle'  , 'comment' ]
let g:which_key_map['e'] = [ ':CocCommand explorer'       , 'explorer' ]
let g:which_key_map['S'] = [ ':Startify'                  , 'start screen' ]


" b
let g:which_key_map.b = {
      \ 'name' : '+buffer' ,
      \ 'd' : [':bd', 'Force close buffer'],
      \ 'D' : [':bd!', 'Force close buffer'],
      \ 'p' : [':bp', 'Previous buffer'],
      \ 'n' : [':bn', 'Next buffer'],
      \ }

" t
let g:which_key_map.t = {
      \ 'name' : '+tab' ,
      \ 'd' : [':td', 'Close tab'],
      \ 'D' : [':td!', 'Force close tab'],
      \ 'p' : [':tp', 'Previous tab'],
      \ 'n' : [':tn', 'Next tab'],
      \ }

" quit
let g:which_key_map.q = {
      \ 'name' : '+quit' ,
      \ 'q' : [':qa', 'Quit all'],
      \ 'Q' : [':qa!', 'Quit all force'],
      \ }

" ranger open
let g:which_key_map.f = {
      \ 'name' : '+ranger' ,
      \ 't' : [':RangerWorkingDirectory', 'Open Working Directory'],
      \ 'o' : [':RangerCurrentFile', 'Open Current Directory'],
      \ 's' : [':w', 'Save'],
      \ }

" s is for search
let g:which_key_map.s = {
      \ 'name' : '+search' ,
      \ '/' : [':History/'     , 'history'],
      \ ';' : [':Commands'     , 'commands'],
      \ 'a' : [':Ag'           , 'text Ag'],
      \ 'b' : [':BLines'       , 'current buffer'],
      \ 'B' : [':Buffers'      , 'open buffers'],
      \ 'c' : [':Commits'      , 'commits'],
      \ 'C' : [':BCommits'     , 'buffer commits'],
      \ 'f' : [':Files'        , 'files'],
      \ 'g' : [':GFiles'       , 'git files'],
      \ 'G' : [':GFiles?'      , 'modified git files'],
      \ 'h' : [':History'      , 'file history'],
      \ 'H' : [':History:'     , 'command history'],
      \ 'l' : [':Lines'        , 'lines'] ,
      \ 'm' : [':Marks'        , 'marks'] ,
      \ 'M' : [':Maps'         , 'normal maps'] ,
      \ 'p' : [':Helptags'     , 'help tags'] ,
      \ 'P' : [':Tags'         , 'project tags'],
      \ 's' : [':Snippets'     , 'snippets'],
      \ 'S' : [':Colors'       , 'color schemes'],
      \ 't' : [':Rg'           , 'text Rg'],
      \ 'T' : [':BTags'        , 'buffer tags'],
      \ 'w' : [':Windows'      , 'search windows'],
      \ 'y' : [':Filetypes'    , 'file types'],
      \ 'z' : [':FZF'          , 'FZF'],
      \ }

" Register which key map
call which_key#register('<Leader>', "g:which_key_map")
call which_key#register('<Space>', "g:which_key_map")
