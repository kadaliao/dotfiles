syntax on
filetype plugin indent on

set hidden
set number
set encoding=UTF-8
set laststatus=2
set backspace=2
set modelines=5
set visualbell
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set incsearch
set ignorecase
set display+=lastline
set nojoinspaces
set relativenumber
set nospell
set inccommand=nosplit
set guifont=DroidSansMono_Nerd_Font:h11
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

"call minpac#add('gcmt/wildfire.vim')

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

" don't use whichkey plugin on special keys
" use <lt> as \<
"nnoremap <silent> <a-f> :<c-u>WhichKey '<lt>a-f>'<cr>

" -----------  custom mapping  ---------------
nnoremap <leader>fve :edit ~/.config/nvim/init.vim<cr>
nnoremap <leader>fvs :source ~/.config/nvim/init.vim<cr>
nnoremap <leader>fs :w<cr>
nmap <leader>mk [m
nmap <leader>mj ]m

" close buffer and quit all
nmap <leader>bd :bd<cr>
nmap <leader>qq :qa<cr>
nmap <leader>qQ :qa!<cr>
nmap <leader>bp :bp<cr>
nmap <leader>bn :bn<cr>

" use cl instead of original s
nmap s <c-w>
nmap sd sc
nmap sg ss

imap jk <esc>
vmap jk <esc>

" just generate tags for python files
nnoremap <leader>mgd :Dispatch! ctags -R -h=".py"<cr>

imap <c-h> <bs>
imap <c-d> <del>
imap <c-k> <c-o>D
imap <c-a> <c-o>I
imap <c-e> <c-o>$

" -----------    custom commands  ---------------

command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()

" Quit help window just by q
augroup EndHelpQ | au! FileType help noremap <buffer> q :q<cr> | augroup END
augroup EndQuickFixQ | au! FileType qf noremap <buffer> q :q<cr> | augroup END

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


" ------------    ranger.vim   ------------------
call minpac#add('francoiscabrol/ranger.vim')
call minpac#add('rbgrouleff/bclose.vim')

nmap <F2> :Ranger<cr>
nmap <leader>ft :RangerWorkingDirectory<cr>
nmap <leader>fo :RangerCurrentFile<cr>

let g:ranger_replace_netrw = 1

" --------------   vim-devicons  -----------------
call minpac#add('ryanoasis/vim-devicons')
let g:airline_powerline_fonts = 1

" --------------   vim-airline  -----------------
call minpac#add('vim-airline/vim-airline')
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'


" --------------   quick fix --------------------
noremap <leader>el :copen<cr>
noremap <leader>eo :cclose<cr>
noremap <leader>en :cnext<cr>
noremap <leader>eN :clast<cr>
noremap <leader>ep :cpre<cr>
noremap <leader>eP :cfirst<cr>

" -----------------   CtrlP --------------------
call minpac#add('ctrlpvim/ctrlp.vim')
nmap <leader>ji :CtrlPBufTagAll<cr>
nmap <leader>jt :CtrlPTag<cr>

nmap <leader>ff :CtrlPCurWD<cr>


set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows


let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$',
  \ 'file': '\v(tags)|\.(exe|so|dll|pyc)$',
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
  "tnoremap <esc> <c-\><c-n>
  tnoremap <a-[> <c-\><c-n>
  "let $GIT_EDITOR = 'nvr -cc split --remote-wait'
endif

"augroup GitCommitNVR
"  autocmd FileType gitcommit set bufhidden=delete
"augroup END


" ---------------  neoterm -------------------
"call minpac#add('kassio/neoterm')

" 3<leader>tl will clear neoterm-3.
"nnoremap <leader>tl :<c-u>exec v:count.'Tclear'<cr>


" ---------------- vim-test ------------------
call minpac#add('janko/vim-test')

" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
nmap <silent> t<c-n> :TestNearest<cr>
nmap <silent> t<c-f> :TestFile<cr>
nmap <silent> t<c-s> :TestSuite<cr>
nmap <silent> t<c-l> :TestLast<cr>
nmap <silent> t<c-g> :TestVisit<cr>

let test#strategy = 'neoterm'

" ------------------- ale --------------------
call minpac#add('w0rp/ale')

" Mappings in the style of unimpaired-next
nmap <silent> [W <plug>(ale_first)
nmap <silent> [w <plug>(ale_previous)
nmap <silent> ]w <plug>(ale_next)
nmap <silent> ]W <plug>(ale_last)
nmap <leader>ts :ALEToggle<cr>

"let b:ale_linters = ['flake8']
let b:ale_linters = {
\   'javascript': ['eslint'],
\   'python': ['flake8'],
\}
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
let b:ale_fixers = [
\   'remove_trailing_lines',
\   'isort',
\   'ale#fixers#generic_python#BreakUpLongLines',
\   'yapf',
\]

"nnoremap <buffer> <silent> <LocalLeader>= :ALEFix<cr>

let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_filetype_changed = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_open_list = 0

" --------------   jedi-vim  -----------------
call minpac#add('davidhalter/jedi-vim')
call minpac#add('ervandew/supertab')

" ---------------- Deoplete -------------------
"call minpac#add('Shougo/deoplete.nvim')
"let g:deoplete#enable_at_startup = 1

" ---------------- Starify -------------------
call minpac#add('mhinz/vim-startify')
" forbid to change directory
let g:startify_change_to_dir = 1


" -------------- AutoFormat  -----------------
call minpac#add('Chiel92/vim-autoformat')
let g:formatter_yapf_style = 'pep8'

" ---------------   CtrlSF   -----------------
call minpac#add('dyng/ctrlsf.vim')
call minpac#add('terryma/vim-multiple-cursors')

let g:ctrlsf_ackprg = '/usr/local/bin/rg'

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
" in search mode, <c-n> to multiple select with plugin vim-multiple-cursors

