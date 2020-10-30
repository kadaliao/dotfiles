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

" Rename the current file in the vim buffer + retain relative path.
Plug 'danro/rename.vim'

" Quoting/parenthesizing made simple
Plug 'tpope/vim-surround'

" enable repeating supported plugin maps with "."
Plug 'tpope/vim-repeat'

" Pairs of handy bracket mappings, [f [[
Plug 'tpope/vim-unimpaired'

" comment stuff out, gcc, gcap
Plug 'tpope/vim-commentary'

" A Vim plugin for Vim plugins; PP, :Vedit
Plug 'tpope/vim-scriptease'

" Asynchronous build and test dispatcher
Plug 'tpope/vim-dispatch'

" Granular project configuration; jump to test file
" Plug 'tpope/vim-projectionist'

" GitHub extension for fugitive.vim; GBrowse
" Plug 'tpope/vim-rhubarb'

" Easily search for, substitute, and abbreviate multiple variants of a word
Plug 'tpope/vim-abolish'

" Create your own text objects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-indent'
Plug 'bps/vim-textobj-python'
" Text objects for the last searched pattern; i/
Plug 'kana/vim-textobj-lastpat'

" Make the yanked region apparent!
Plug 'machakann/vim-highlightedyank'

" Adds neovim support to vim-dispatch
Plug 'radenling/vim-dispatch-neovim'

" Fuzzy file, buffer, mru, tag, etc finder.
Plug 'ctrlpvim/ctrlp.vim'

" A Vim plugin to colorize all text in the form #rrggbb or #rgb.
Plug 'lilydjwg/colorizer'

" Theme
Plug 'morhetz/gruvbox'

" Vim plugin that displays tags in a window, ordered by scope
Plug 'majutsushi/tagbar'

" A Vim plugin which shows git diff markers in the sign column and stages/previews/undoes hunks and partial hunks.
Plug 'airblade/vim-gitgutter'

" Ranger integration in vim and neovim, with dependency bclose
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'

" Adds file type icons to Vim plugins such as: NERDTree, vim-airline, CtrlP, unite, Denite, lightline, vim-startify and many more
Plug 'ryanoasis/vim-devicons'

" Lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline'

" An ack.vim alternative mimics Ctrl-Shift-F on Sublime Text 2
Plug 'dyng/ctrlsf.vim'

" Multiple cursors plugin for vim/neovim
Plug 'mg979/vim-visual-multi'

" Better whitespace highlighting for Vim
Plug 'ntpeters/vim-better-whitespace'

" The fancy start screen for Vim.
Plug 'mhinz/vim-startify'

" Provides an executable called nvr, Controlling nvim processes from the shell. E.g. opening files in another terminal window, Opening files from within :terminal without starting a nested nvim process.
Plug 'mhinz/neovim-remote'

" Vim motions on speed!
Plug 'easymotion/vim-easymotion'

" Plugin to toggle, display and navigate marks
Plug 'kshenoy/vim-signature'

" Awesome Python autocompletion with VIM
Plug 'davidhalter/jedi-vim'

" Semantic Highlighting for Python in Neovim
Plug 'numirias/semshi', {'do': 'UpdateRemotePlugins'}

" Remote Plugin Framework for Neovim; 
Plug 'roxma/nvim-yarp'

" Slim, Fast and Hackable Completion Framework for Neovim
Plug 'ncm2/ncm2'

" Python completion for ncm2 via the great jedi library.
Plug 'ncm2/ncm2-jedi'

" completion words from current buffer
Plug 'ncm2/ncm2-bufword'

" Completion words from path
Plug 'ncm2/ncm2-path'

" UltiSnips integration for ncm2.
Plug 'ncm2/ncm2-ultisnips'

" Ultimate solution for snippets in Vim.
Plug 'SirVer/ultisnips'

" Vim-snipmate default snippets
Plug 'honza/vim-snippets'

" A Vim wrapper for running tests on different granularities.
Plug 'janko/vim-test'

" Check syntax in Vim asynchronously and fix files, with Language Server Protocol (LSP) support
Plug 'dense-analysis/ale'

" Markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" Vim plugin for insert mode completion of words in adjacent tmux panes
Plug 'wellle/tmux-complete.vim'

" Seamless navigation between tmux panes and vim splits
Plug 'christoomey/vim-tmux-navigator'

" Rst preview
Plug 'kadaliao/InstantRst'

" Start a * or # search from a visual block
Plug 'bronson/vim-visual-star-search'

" send code to a live REPL
Plug 'jpalardy/vim-slime'

" re-run ctags on a source file when you save it
Plug 'craigemery/vim-autotag'

" A collection of language packs for Vim.
Plug 'sheerun/vim-polyglot'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        Plugin settings and mappings                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""
"  theme  "
"""""""""""
set background=dark
colorscheme gruvbox



""""""""""""""""""""""
"  Leader clipboard  "
""""""""""""""""""""""
vnoremap <Leader>y "+y
vnoremap <Leader>x "+x
vnoremap <Leader>d "+d
vnoremap <Leader>p "+p
vnoremap <Leader>P "+P
nnoremap <Leader>Y "+Y
nnoremap <Leader>yy "+yy
nnoremap <Leader>x "+x
nnoremap <Leader>dd "+dd
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P

"""""""""""""""
"  vim-slime  "
"""""""""""""""

let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{down-of}"}
let g:slime_python_ipython = 1


""""""""""""""""
"  instantRst  "
""""""""""""""""

let g:instant_rst_browser = 'Google Chrome'

""""""""""""
"  tagbar  "
""""""""""""

let g:tagbar_autoclose = 0
let g:tagbar_autofocus = 1
let g:tagbar_autopreview = 0
let g:tagbar_compact = 1
let g:tagbar_left = 1
let g:tagbar_autoshowtag = 1

nmap <F3> :TagbarToggle<CR>


""""""""""""""""""
"  tig-explorer  "
""""""""""""""""""

" open tig with current file
nnoremap <Leader>gf :TigOpenCurrentFile<CR>

" open tig with Project root path
nnoremap <Leader>gt :TigOpenProjectRootDir<CR>

" open tig grep
nnoremap <Leader>gg :TigGrep<CR>

" resume from last grep
nnoremap <Leader>gr :TigGrepResume<CR>

" open tig grep with the selected word
vnoremap <Leader>gs y:TigGrep<Space><C-R>"<CR>

" open tig grep with the word under the cursor
nnoremap <Leader>gw :<C-u>:TigGrep<Space><C-R><C-W><CR>

" open tig blame with current file
nnoremap <Leader>gb :TigBlame<CR>


"""""""""""""""
"  gitgutter  "
"""""""""""""""

let g:gitgutter_map_keys = 0

nnoremap <leader>gp :silent! GitGutterPreviewHunk<cr>
nnoremap <leader>gd :pclose<cr>
nnoremap <leader>tg :GitGutterToggle<cr>
autocmd BufWritePost * GitGutter

nmap [g <Plug>GitGutterPrevHunk
nmap ]g <Plug>GitGutterNextHunk

function! PreviewWindowOpened()
    for nr in range(1, winnr('$'))
        if getwinvar(nr, '&pvw') == 1
            "found a preview
            " return 1
        endif
    endfor
    return 0
endfunction


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
  \ 'dir':  '\v[\/](node_modules|target|dist|venv|env)|(\.(swp|ico|git|svn|env|venv))$',
  \ 'file': '\v(tags)|\.(exe|so|dll|pyc)$',
  \ }


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

""""""""""""""""""""""""""""
"  scroll the other split  "
""""""""""""""""""""""""""""
nnoremap <a-u>  <C-w>p<C-u><C-w>p
nnoremap <a-d>  <C-w>p<C-d><C-w>p


"""""""""""""
"  neoterm  "
"""""""""""""

" Plug 'kassio/neoterm'

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

" Install neovim in specified virtualenv
"
if empty(glob('~/.cache/vim/venv/neovim3/bin/python'))
	!python3 -m venv ~/.cache/vim/venv/neovim3
	!~/.cache/vim/venv/neovim3/bin/pip install neovim jedi
endif

" Python host for neovim
let g:python3_host_prog = '~/.cache/vim/venv/neovim3/bin/python'

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

" Press <c-y> to trigger snippet expansion
" The parameters are the same as `:help feedkeys()`
inoremap <silent> <expr> <c-y> ncm2_ultisnips#expand_or("\<CR>", 'n')


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
"let g:jedi#documentation_command = '<s-k>'
let g:jedi#goto_command = '<leader>ge'
let g:jedi#goto_assignments_command  = '<leader>gg'
let g:jedi#goto_definitions_command  = '<leader>gd'
let g:jedi#rename_command = '<leader>gr'
let g:jedi#usages_command  = '<leader>gn'
let g:jedi#goto_stubs_command = '<leader>gs'


""""""""""""
"  semshi  "
""""""""""""
nnoremap <leader>ti :Semshi toggle<cr>

""""""""""""""""""""
"  tmux-navigator  "
""""""""""""""""""""
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <a-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <a-j> :TmuxNavigateDown<cr>
nnoremap <silent> <a-k> :TmuxNavigateUp<cr>
nnoremap <silent> <a-l> :TmuxNavigateRight<cr>
nnoremap <silent> <a-o> :TmuxNavigatePrevious<cr>


"""""""""
"  ale  "
"""""""""
let g:ale_linters = {
\   'python': ['flake8', 'pylint'],
\   'vim':  ['vint'],
\   'markdown': ['markdownlint'],
\   'sh': ['shellcheck'],
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'json': ['jq'],
\   'python': ['black', 'isort'],
\   'sh': ['shfmt'],
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
vnoremap <leader>bf :'<,'>!autopep8 -<cr>




"""""""""""""""""""""""
"  textobject-python  "
"""""""""""""""""""""""

let g:textobj_python_no_default_key_mappings = 1

autocmd BufEnter *.py call textobj#user#map('python', {
      \   'class': {
      \     'select-a': '<buffer>ac',
      \     'select-i': '<buffer>ic',
      \     'move-n': '<buffer>]c',
      \     'move-p': '<buffer>[c',
      \   },
      \   'function': {
      \     'select-a': '<buffer>af',
      \     'select-i': '<buffer>if',
      \   }
      \ })
      " \     'move-n': '<buffer>]f',
      " \     'move-p': '<buffer>[f',

""""""""""""""""""""""
"  markdown-preview  "
""""""""""""""""""""""

nmap <F4> <Plug>MarkdownPreviewToggle
let g:mkdp_auto_start = 0

""""""""""""""""""""""
"       UndoTree     "
""""""""""""""""""""""

nnoremap <F5> :UndotreeToggle<cr>


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
set foldmethod=marker
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

noremap sz <c-w>_ \| <c-w>\|
" open current split into a new tab
noremap sc :tabnew %<CR>

" close buffer and quit all
nnoremap <leader>bd :bd<cr>
nnoremap <leader>bD :q!<cr>
nnoremap <leader>qq :qa<cr>
nnoremap <leader>qQ :qa!<cr>
nnoremap <leader>bp :bp<cr>
nnoremap <leader>bn :bn<cr>

nnoremap <leader>tp :tabp<cr>
nnoremap <leader>tn :tabn<cr>
nnoremap <leader>td :tabclose<cr>
nnoremap <leader>tD :tabclose!<cr>

tnoremap <leader>qq <esc>

" use cl instead of original s
nnoremap s <c-w>
nnoremap sd <c-w>c
nnoremap sv <c-w>v
nnoremap sg <c-w>s
nnoremap vs <c-w>v

inoremap jk <esc>
"vmap jk <c-[>
"imap jk <esc>
"vmap jk <esc>

" shit-tab to unindent
inoremap <S-Tab> <C-o><<

" inoremap <c-h> <bs>
inoremap <expr> <c-h> pumvisible() ? "\<C-h>" : "<bs>"
inoremap <c-d> <del>
inoremap <c-k> <c-o>D
inoremap <c-a> <c-o>I
inoremap <expr> <c-e> pumvisible() ? "\<C-e>" : "\<C-o>$"
inoremap <c-p> <up>
inoremap <c-f> <right>
inoremap <c-b> <left>
inoremap <c-n> <down>

" Deleting current buffer without losing the split
" nnoremap <silent> <c-x> :bp\|bd #<cr>

" Fold file based on syntax
" nnoremap <leader>zs :setlocal foldmethod=syntax<cr>
" nnoremap <leader>zt :setlocal nofoldenable<cr>

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
tnoremap <a-8> <c-\><c-n>
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
" no need if use with tmux-navigator
" tnoremap <a-h> <C-\><C-N><C-w>h
" tnoremap <a-j> <C-\><C-N><C-w>j
" tnoremap <a-k> <C-\><C-N><C-w>k
" tnoremap <a-l> <C-\><C-N><C-w>l
" inoremap <a-h> <C-\><C-N><C-w>h
" inoremap <a-j> <C-\><C-N><C-w>j
" inoremap <a-k> <C-\><C-N><C-w>k
" inoremap <a-l> <C-\><C-N><C-w>l
" nnoremap <a-h> <C-w>h
" nnoremap <a-j> <C-w>j
" nnoremap <a-k> <C-w>k
" nnoremap <a-l> <C-w>l

" do not quit entire vim
augroup GitCommitNVR
  "autocmd FileType gitcommit set bufhidden=delete
  autocmd FileType gitcommit nmap <leader>qq :q<cr>
augroup END

" just generate tags for python files
" nnoremap <leader>mgd :Dispatch! ctags (find . -type f -iname "*.py")<cr>
" nnoremap <leader>mgd :Dispatch! ctags -R .<cr>
