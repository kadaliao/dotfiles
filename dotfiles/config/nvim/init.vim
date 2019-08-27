let $VIMCONFIG = '~/.config/nvim'
let $MYVIMRC = $VIMCONFIG . '/init.vim'

if empty(glob($VIMCONFIG . '/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Plugins                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin($VIMCONFIG . '/plugged')

Plug 'vim-scripts/LargeFile'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'lxhillwind/leader-clipboard'
Plug 'machakann/vim-highlightedyank'
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-projectionist'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'lilydjwg/colorizer'
Plug 'morhetz/gruvbox'
Plug 'liuchengxu/vim-which-key'
Plug 'majutsushi/tagbar'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'dyng/ctrlsf.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'ntpeters/vim-better-whitespace'
Plug 'mhinz/vim-startify'
Plug 'mhinz/neovim-remote'
Plug 'easymotion/vim-easymotion'
Plug 'kshenoy/vim-signature'
Plug 'davidhalter/jedi-vim'
Plug 'numirias/semshi', {'do': 'UpdateRemotePlugins'}
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-ultisnips'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'janko/vim-test'
Plug 'dense-analysis/ale'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        Plugin settings and mappings                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""
"  theme  "
"""""""""""

colorscheme gruvbox


""""""""""""""
"  whichkey  "
""""""""""""""

nnoremap <silent> <leader>hg :<c-u>WhichKey 'g'<cr>
nnoremap <silent> <leader>hm :<c-u>WhichKey 'm'<cr>
nnoremap <silent> <leader>h[ :<c-u>WhichKey '['<cr>
nnoremap <silent> <leader>h] :<c-u>WhichKey ']'<cr>
nnoremap <silent> <leader>hy :<c-u>WhichKey 'y'<cr>
nnoremap <silent> <leader>hg :<c-u>WhichKey 'g'<cr>
nnoremap <silent> <leader>h<leader> :<c-u>WhichKey '<leader>'<cr>
"nnoremap <silent> <leader> :<c-u>WhichKey '<leader>'<cr>
"nnoremap <silent> [ :<c-u>WhichKey '['<cr>
"nnoremap <silent> ] :<c-u>WhichKey ']'<cr>
"nnoremap <silent> ] :<c-u>WhichKey ']'<cr>

" don't use whichkey plugin on special keys
" use <lt> as \<
"nnoremap <silent> <a-f> :<c-u>WhichKey '<lt>a-f>'<cr>


""""""""""""
"  tagbar  "
""""""""""""

let g:tagbar_autoclose = 0
let g:tagbar_autofocus = 1
let g:tagbar_autopreview = 0
let g:tagbar_compact = 1
let g:tagbar_left = 1
"let g:tagbar_autoshowtag = 1

nmap <F3> :TagbarToggle<CR>

"""""""""""""""
"  gitgutter  "
"""""""""""""""

let g:gitgutter_map_keys = 0

nnoremap <leader>gp :silent! GitGutterPreviewHunk<cr>
nnoremap <leader>go :pclose<cr>
nnoremap <leader>tg :GitGutterToggle<cr>
autocmd BufWritePost * GitGutter

nmap [g <Plug>GitGutterPrevHunk
nmap ]g <Plug>GitGutterNextHunk

"function! PreviewWindowOpened()
"    for nr in range(1, winnr('$'))
"        if getwinvar(nr, '&pvw') == 1
"            "found a preview
"            " return 1
"        endif
"    endfor
"    return 0
"endfunction


""""""""""""""
"  fugitive  "
""""""""""""""

let g:github_enterprise_urls = ['https://github-fm.intra.douban.com']


""""""""""""
"  ranger  "
""""""""""""

nmap <F2> :Ranger<cr>
nmap <leader>ft :RangerWorkingDirectory<cr>
nmap <leader>fo :RangerCurrentFile<cr>
let g:ranger_map_keys = 0
let g:ranger_replace_netrw = 1


""""""""""""""
"  devicons  "
""""""""""""""

let g:airline_powerline_fonts = 1
let g:codedark_conservative = 1


"""""""""""""
"  tabline  "
"""""""""""""

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'


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
  \ 'dir':  '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$',
  \ 'file': '\v(tags)|\.(exe|so|dll|pyc)$',
  \ }


""""""""""""
"  ctrlsf  "
""""""""""""

let g:ctrlsf_ackprg = '/usr/local/bin/rg'
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


"""""""""""""
"  neoterm  "
"""""""""""""

" Plug 'kassio/neoterm')

"let g:neoterm_autoinsert = 1
"let g:neoterm_keep_term_open = 1

"" quickly toggle terminal
"nnoremap <silent> <leader>o :rightbelow Ttoggle<cr>
"nnoremap <silent> <leader><leader> :rightbelow Ttoggle<cr>
"nnoremap <silent> <leader>O :vertical botright Ttoggle<cr>

"" close term
"tnoremap <silent> <leader><leader> <c-\><c-n>:Ttoggle<cr>
"tnoremap <silent> <leader><leader> <c-\><c-n>:Ttoggle<cr>


"" 3<leader>tl will clear neoterm-3.
"nnoremap <leader>tl :<c-u>exec v:count.'Tclear'<cr>


"""""""""""""""
"  neoremote  "
"""""""""""""""

let $VISUAL      = 'nvr -cc split --remote-wait +"setlocal bufhidden=delete"'
let $GIT_EDITOR  = 'nvr -cc split --remote-wait +"setlocal bufhidden=delete"'
let $EDITOR      = 'nvr -l'
let $ECTO_EDITOR = 'nvr -l'

" share data between nvim instances (registers etc)
augroup SHADA
  autocmd!
  autocmd CursorHold,TextYankPost,FocusGained,FocusLost *
        \ if exists(':rshada') | rshada | wshada | endif
augroup END


""""""""""""""
"  vim-test  "
""""""""""""""

" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
nmap <silent> t<c-n> :TestNearest<cr>
nmap <silent> t<c-f> :TestFile<cr>
nmap <silent> t<c-s> :TestSuite<cr>
nmap <silent> t<c-l> :TestLast<cr>
nmap <silent> t<c-g> :TestVisit<cr>

"let test#strategy = 'neoterm'

"""""""""""""""""""""""
"  better-whitespace  "
"""""""""""""""""""""""

let g:better_whitespace_enabled = 1


"""""""""""""
"  starify  "
"""""""""""""

" forbid to change directory
let g:startify_change_to_dir = 1


""""""""""""""""
"  easymotion  "
""""""""""""""""

let g:EasyMotion_do_mapping = 0

map <leader>jl <plug>(easymotion-bd-jk)
nmap <leader>jl <plug>(easymotion-overwin-line)
map  <leader>jw <plug>(easymotion-bd-w)
nmap <leader>jw <plug>(easymotion-overwin-w)


""""""""""
"  ncm2  "
""""""""""

autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=menuone,noselect,noinsert

" make it fast
let ncm2#popup_delay = 5
let ncm2#complete_length = [[1, 1]]
" Use new fuzzy based matches
let g:ncm2#matcher = 'substrfuzzy'

" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" wrap existing omnifunc
" Note that omnifunc does not run in background and may probably block the
" editor. If you don't want to be blocked by omnifunc too often, you could
" add 180ms delay before the omni wrapper:
"  'on_complete': ['ncm2#on_complete#delay', 180,
"               \ 'ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
" au User Ncm2Plugin call ncm2#register_source({
"         \ 'name' : 'css',
"         \ 'priority': 9,
"         \ 'subscope_enable': 1,
"         \ 'scope': ['css','scss'],
"         \ 'mark': 'css',
"         \ 'word_pattern': '[\w\-]+',
"         \ 'complete_pattern': ':\s*',
"         \ 'on_complete': ['ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
"         \ })
" autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS noci

" Press <c-l> to trigger snippet expansion
" The parameters are the same as `:help feedkeys()`
inoremap <silent> <expr> <c-l> ncm2_ultisnips#expand_or("\<CR>", 'n')

"""""""""""""""
"  ultisnips  "
"""""""""""""""

" c-j c-k for moving in snippet
let g:UltiSnipsExpandTrigger		= "<Plug>(ultisnips_expand)"
let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0


""""""""""""""
"  jedi-vim  "
""""""""""""""

" Disable Jedi-vim autocompletion and enable call-signatures options
let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_command = ''
let g:jedi#show_call_signatures = 1

"let g:jedi#use_splits_not_buffers = ""
"let g:jedi#completions_command = "<C-N>"
let g:jedi#goto_command = '<leader>ge'
let g:jedi#goto_assignments_command  = '<leader>gg'
let g:jedi#goto_definitions_command  = '<leader>gd'
let g:jedi#documentation_command = '<s-k>'
let g:jedi#rename_command = '<leader>gr'
let g:jedi#usages_command  = '<leader>gn'
let g:jedi#goto_stubs_command = '<leader>gs'


"""""""""
"  ale  "
"""""""""
let g:ale_linters = {
\   'python': ['pylint'],
\   'vim':  ['vint'],
\   'markdown': ['markdownlint']
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'json': ['jq'],
\   'python': ['autopep8', 'isort', 'yapf'],
\}

let g:ale_fix_on_save = 0
let g:ale_set_highlights = 0
let g:ale_completion_enabled = 0
let g:ale_sign_column_always = 0
let g:airline#extensions#ale#enabled = 1

" use localtion list navigate key
"nmap <silent> <leader><C-k> <Plug>(ale_previous_wrap)
"nmap <silent> <leader><C-j> <Plug>(ale_next_wrap)
nnoremap <leader>ts :ALEToggle<cr>
nnoremap <leader>bf :ALEFix<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              Common Settings                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" transparent background
" hi Normal guibg=NONE ctermbg=NONE


syntax on
filetype plugin indent on
set hidden
set number
set encoding=UTF-8
set laststatus=2
set termguicolors
set mouse=a
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
          \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
          \,sm:block-blinkwait175-blinkoff150-blinkon175
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
set cursorline
set undofile
"set guifont=DroidSansMono_Nerd_Font:h11
"set cursorcolumn
"set bufhidden=delete


" use \" here, \' won't work
let g:mapleader = "\\"

nmap <space> \
xmap <space> \

nnoremap <leader>fve :edit $MYVIMRC<cr>
nnoremap <leader>fvs :source $MYVIMRC<cr>
nnoremap <leader>fs :w<cr>

noremap Zz <c-w>_ \| <c-w>\|
noremap Zo <c-w>=

" close buffer and quit all
nnoremap <leader>bd :bd<cr>
nnoremap <leader>bD :q!<cr>
nnoremap <leader>qq :qa<cr>
nnoremap <leader>qQ :qa!<cr>
nnoremap <leader>bp :bp<cr>
nnoremap <leader>bn :bn<cr>

tnoremap <leader>qq <esc>

" use cl instead of original s
nnoremap s <c-w>
nnoremap sd <c-w>c
nnoremap sv <c-w>v
nnoremap sg <c-w>s
nnoremap vs <c-w>v
nnoremap q <esc>
nnoremap q <esc>
nnoremap <leader>qr q

imap jk <esc>
"vmap jk <c-[>
"imap jk <esc>
"vmap jk <esc>

imap <c-h> <bs>
imap <c-d> <del>
imap <c-k> <c-o>D
imap <c-a> <c-o>I
imap <c-e> <c-o>$
imap <c-p> <up>
imap <c-f> <right>
imap <c-b> <left>
imap <c-n> <down>

" Deleting current buffer without losing the split
nnoremap <silent> <c-x> :bp\|bd #<cr>

" Fold file based on syntax
nnoremap <leader>zs :setlocal foldmethod=syntax<cr>
nnoremap <leader>zt :setlocal nofoldenable<cr>

" Rename current file
"nnoremap <leader>rn :Move <c-r>=expand("%")<cr>

" Replace word under cursor, globally, with confirmation
"nnoremap <Leader>rk :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>
"vnoremap <Leader>rk y :%s/<C-r>"//gc<Left><Left><Left>

" Remove highlighting on escape
nmap <silent> <esc> :nohlsearch<cr>

" Quit help window just by q
augroup EndHelpQ | au! FileType help noremap <buffer> q :q<cr> | augroup END
augroup EndQuickFixQ | au! FileType qf noremap <buffer> q :q<cr> | augroup END

" Automatically source the vimrc file on save
augroup AutoSourcing
  autocmd!
  autocmd BufWritePost ~/.config/nvim/init.vim source $MYVIMRC
augroup END

" Put quick fix under main window
"augroup DragQuickfixWindowDown
"    autocmd!
"    autocmd FileType qf wincmd J
"augroup end

"""""""""""""""
"  LargeFile  "
"""""""""""""""
let g:LargeFile = 5

""""""""""""""
"  quickfix  "
""""""""""""""

noremap <leader>ql :copen<cr>
noremap <leader>qo :cclose<cr>
noremap <leader>qn :cnext<cr>
noremap <leader>qN :clast<cr>
noremap <leader>qp :cpre<cr>
noremap <leader>qP :cfirst<cr>

"""""""""""""""""""
"  location list  "
"""""""""""""""""""

noremap <leader>el :lopen<cr>
noremap <leader>eo :lclose<cr>
noremap <leader>en :lnext<cr>
noremap <leader>eN :llast<cr>
noremap <leader>ep :lpre<cr>
noremap <leader>eP :lfirst<cr>


""""""""""""""
"  terminal  "
""""""""""""""

" <esc> will work as <esc> in terminal
" this works well if you change the system input shortcut <c-space> to
" something like <c-8>
tnoremap <c-space> <c-\><c-n>
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
tnoremap <a-h> <C-\><C-N><C-w>h
tnoremap <a-j> <C-\><C-N><C-w>j
tnoremap <a-k> <C-\><C-N><C-w>k
tnoremap <a-l> <C-\><C-N><C-w>l
inoremap <a-h> <C-\><C-N><C-w>h
inoremap <a-j> <C-\><C-N><C-w>j
inoremap <a-k> <C-\><C-N><C-w>k
inoremap <a-l> <C-\><C-N><C-w>l
nnoremap <a-h> <C-w>h
nnoremap <a-j> <C-w>j
nnoremap <a-k> <C-w>k
nnoremap <a-l> <C-w>l

" do not quit entire vim
augroup GitCommitNVR
  "autocmd FileType gitcommit set bufhidden=delete
  autocmd FileType gitcommit nmap <leader>qq :q<cr>
augroup END

" just generate tags for python files
nnoremap <leader>mgd :Dispatch! ctags (find . -type f -iname "*.py")<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Notes and tips                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

" xmap visual
" vmap visula and select
" omap operator pending
" lmap Insert, Command-line, Lang-Arg
" tmap Terminal-Job
" cmap Command-line
