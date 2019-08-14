syntax on
filetype plugin indent on

set number
set laststatus=2
set backspace=2
set modelines=5
set visualbell
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set incsearch
set ignorecase
set display+=lastline
set nojoinspaces
set relativenumber
set nospell
set inccommand=nosplit
"set cursorline
"set cursorcolumn

packadd minpac
call minpac#init()

call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-unimpaired')

call minpac#add('machakann/vim-highlightedyank')
call minpac#add('lxhillwind/leader-clipboard')

call minpac#add('tpope/vim-scriptease', {'type': 'opt'})
call minpac#add('tpope/vim-projectionist', {'type': 'opt'})
call minpac#add('leafgarland/typescript-vim', {'type': 'opt'})
call minpac#add('k-takata/minpac', {'type': 'opt'})

call minpac#add('tpope/vim-dispatch')
call minpac#add('radenling/vim-dispatch-neovim')

call minpac#add('gcmt/wildfire.vim')

call minpac#add('morhetz/gruvbox')
colorscheme gruvbox


" use \" here, \' won't work
let g:mapleader = "\<space>"
let g:maplocalleader = '\'

" ---------------- whichkey ------------------
call minpac#add('liuchengx/vim-which-key')

nnoremap <silent> <leader>      :<c-u>WhichKey '<space>'<cr>
nnoremap <silent> <localleader> :<c-u>WhichKey '<space>'<cr>
nnoremap <silent> [ :<c-u>WhichKey '['<cr>
nnoremap <silent> ] :<c-u>WhichKey ']'<cr>

" -----------  custom mapping  ---------------
nnoremap <leader>fve :tabedit ~/.config/nvim/init.vim<cr>
"nnoremap <leader>fvs :source ~/.config/nvim/init.vim<cr>
nnoremap <leader>fs :w<cr>
nmap <leader>mk [m
nmap <leader>mj ]m

" close buffer and quit all
nmap <leader>bd :q<cr>
nmap <leader>qq :qa<cr>

nmap <silent> <leader>bp :tabp<cr>
nmap <silent> <leader>bn :tabn<cr>

imap jk <esc>
vmap jk <esc>

" just generate tags for python files
nnoremap <leader>mgd :Dispatch! ctags -R -h=".py"<cr>

imap <c-h> <bs>
imap <c-d> <del>
imap <c-k> <c-o>D
imap <c-a> <c-o>I
imap <c-e> <c-o>$

" ----------- custom commands  ---------------

command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()

" Quit help window just by q
autocmd FileType help noremap <buffer> q :q<cr>
autocmd FileType qf noremap <buffer> q :q<cr>

" Automatically source the vimrc file on save
augroup autosourcing
  autocmd! 
  autocmd BufWritePost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim
augroup END

" Put quick fix under main window
augroup DragQuickfixWindowDown
    autocmd!
    autocmd FileType qf wincmd J
augroup end


" ---------------- NerdTree ------------------
call minpac#add('scrooloose/nerdtree')
call minpac#add('Xuyuanp/nerdtree-git-plugin')

nmap <F2> :NERDTreeToggle<cr>
nmap <leader>ft :NERDTreeToggle<cr>
nmap <leader>fo :NERDTreeFind<cr>

let NERDTreeHijackNetrw = 1
let NERDTreeQuitOnOpen = 0
let NERDTreeWinPos = 'right'
let NERDTreeAutoDeleteBuffer = 1
"let NERDTreeMinimalUI = 1
"let NERDTreeDirArrows = 1

augroup NerdEnter
  autocmd!
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
augroup END

" Auto open for each tab if NerdTree exists, abnormal with quickfix window
" autocmd BufWinEnter * NERDTreeMirror

" Auto quit Vim when actual files are closed
function! s:CheckLeftBuffers(quitpre)
  if tabpagenr('$') == 1
    let i = 1
    while i <= winnr('$')
      if a:quitpre && i == winnr()
        let i += 1
        continue
      endif
      let filetypes = ['help', 'qf', 'nerdtree', 'taglist']
      if index(filetypes, getbufvar(winbufnr(i), '&filetype')) >= 0 ||
            \ getwinvar(i, '&previewwindow')
        let i += 1
      else
        break
      endif
    endwhile
    if i == winnr('$') + 1
      call feedkeys(":only\<CR>:q\<CR>", 'n')
    endif
  endif
endfunction
augroup AutoQuit
  autocmd!
  if exists('##QuitPre')
    autocmd QuitPre * call s:CheckLeftBuffers(1)
  else
    autocmd BufEnter * call s:CheckLeftBuffers(0)
  endif
augroup END

" --------------   jedi-vim  -----------------
call minpac#add('davidhalter/jedi-vim')
call minpac#add('ervandew/supertab')

 
" --------------   quick fix -----------------
noremap <leader>el :copen<cr>
noremap <leader>eo :cclose<cr>
noremap <leader>en :cnext<cr>
noremap <leader>ep :cpre<cr>

" -----------------   CtrlP --------------------
call minpac#add('ctrlpvim/ctrlp.vim')
nmap <leader>tji :CtrlPBufTagAll<cr>
nmap <leader>tjs :CtrlPTag<cr>
nmap <leader>fje :CtrlPMRUFiles<cr>
nmap <leader>fjb :CtrlPBuffer<cr>
nmap <leader>ff :CtrlPCurWD<cr>


set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|venv\|env'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }



" ------------   easy motion  ----------------
call minpac#add('easymotion/vim-easymotion')

" <Leader>f{char} to move to {char}
" map  <Leader>f <plug>(easymotion-bd-f)
" nmap <Leader>f <plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
" nmap <Leader>s <plug>(easymotion-overwin-f2)

" Movesymotion-overwin-w) to line
map <leader>jl <plug>(easymotion-bd-jk)
nmap <leader>jl <plug>(easymotion-overwin-line)

" Move to word
map  <leader>jw <plug>(easymotion-bd-w)
nmap <leader>jw <plug>(easymotion-overwin-w)


" --------------   terminal ------------------
if has('nvim')
  tnoremap <esc> <c-\><c-n>
  tnoremap <a-[> <esc>
  " switching between split windows
endif


" ---------------  neoterm -------------------
call minpac#add('kassio/neoterm')

" 3<leader>tl will clear neoterm-3.
nnoremap <leader>tl :<c-u>exec v:count.'Tclear'<cr>


" ---------------- vim-test ------------------
call minpac#add('janko/vim-test')

" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
nmap <silent> t<c-n> :TestNearest<cr>
nmap <silent> t<c-f> :TestFile<cr>
nmap <silent> t<c-s> :TestSuite<cr>
nmap <silent> t<c-l> :TestLast<cr>
nmap <silent> t<c-g> :TestVisit<cr>

let test#strategy = "neoterm"

" ------------------- ale --------------------
call minpac#add('w0rp/ale')

" Mappings in the style of unimpaired-next
nmap <silent> [W <plug>(ale_first)
nmap <silent> [w <plug>(ale_previous)
nmap <silent> ]w <plug>(ale_next)
nmap <silent> ]W <plug>(ale_last)
nmap <leader>ts :ALEToggle<cr>

let b:ale_linters = ['flake8']
let b:ale_fixers = [
\   'remove_trailing_lines',
\   'isort',
\   'ale#fixers#generic_python#BreakUpLongLines',
\   'yapf',
\]

nnoremap <buffer> <silent> <LocalLeader>= :ALEFix<cr>


let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_filetype_changed = 0


" ---------------- Starify -------------------
call minpac#add('mhinz/vim-startify')
" forbid to change directory
let g:startify_change_to_dir = 1


" -------------- AutoFormat  -----------------
call minpac#add('Chiel92/vim-autoformat')
let g:formatter_yapf_style = 'pep8'

" ---------------   CtrlSF   -----------------
call minpac#add('dyng/ctrlsf.vim')
let g:ctrlsf_ackprg = '/usr/local/bin/rg'

let g:ctrlsf_auto_focus = {
    \ 'at' : 'start',
    \ 'duration_less_than': 1000
    \ }

"Input :CtrlSF in command line for you
nmap     <c-f>f <plug>CtrlSFPrompt

"Prepare to search visual selected word
vmap     <c-f>f <plug>CtrlSFVwordPath

"Immediately search visual selected word
vmap     <c-f>F <plug>CtrlSFVwordExec

"Prepare to search the word under cursor
"nmap     <c-f>n <plug>CtrlSFCwordPath

"Prepare to search the word under cursor and add boundary to it
"nmap     <c-f>p <plug>CtrlSFPwordPath

nnoremap <c-f>o :CtrlSFOpen<cr>
nnoremap <c-f>t :CtrlSFToggle<cr>
inoremap <c-f>t <esc>:CtrlSFToggle<cr>

" ------------ Notes and tips  ---------------
call minpac#add('terryma/vim-multiple-cursors')


" ------------ Notes and tips  ---------------
" C-] to go to the tag 
" C-^ jump between the location
" C-t jump to previous tag
" []q to go to previous and next quick fix item
" []w to go to the syntax warnings
" 
" <leader>g go to definition, includes declaration
" <leader>d go to definition
" <leader>n find all use in quickfix window
" & to repeat last substitute command

