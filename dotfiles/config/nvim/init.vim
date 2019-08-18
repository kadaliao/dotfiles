syntax on
filetype plugin indent on

set hidden
set number
set encoding=UTF-8
set laststatus=2
set termguicolors
set mouse=a
"set guifont=DroidSansMono_Nerd_Font:h11
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
          \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
          \,sm:block-blinkwait175-blinkoff150-blinkon175
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
set cursorline
set undofile
"set cursorcolumn
"set bufhidden=delete

packadd minpac
call minpac#init()

call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('lxhillwind/leader-clipboard')

call minpac#add('tpope/vim-dispatch')
call minpac#add('radenling/vim-dispatch-neovim')

call minpac#add('tpope/vim-scriptease', {'type': 'opt'})
call minpac#add('tpope/vim-projectionist', {'type': 'opt'})
call minpac#add('leafgarland/typescript-vim', {'type': 'opt'})
call minpac#add('k-takata/minpac', {'type': 'opt'})
call minpac#add('lilydjwg/colorizer', {'type': 'opt'})

"call minpac#add('gcmt/wildfire.vim')

call minpac#add('morhetz/gruvbox')
colorscheme gruvbox


" use \" here, \' won't work
let g:mapleader = "\\"

nmap <space> \
xmap <space> \

" ---------------- whichkey ------------------
call minpac#add('liuchengx/vim-which-key')

nnoremap <silent> <leader> :<c-u>WhichKey '<leader>'<cr>
nnoremap <silent> [ :<c-u>WhichKey '['<cr>
nnoremap <silent> ] :<c-u>WhichKey ']'<cr>

" don't use whichkey plugin on special keys
" use <lt> as \<
"nnoremap <silent> <a-f> :<c-u>WhichKey '<lt>a-f>'<cr>

" -----------  custom mapping  ---------------
nnoremap <leader>fve :edit ~/.config/nvim/init.vim<cr>
nnoremap <leader>fvs :source ~/.config/nvim/init.vim<cr>
nnoremap <leader>fs :w<cr>

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
"nnoremap sv <c-w>v
nnoremap sg <c-w>s
nnoremap vs <c-w>v
nnoremap q <esc>
vnoremap q <esc>
nnoremap <leader>qr q


imap jk <esc>
vmap jk <c-[>
"imap jk <esc>
"vmap jk <esc>

" just generate tags for python files
nnoremap <leader>mgd :Dispatch! ctags -R -h=".py"<cr>

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
nnoremap <Leader>rk :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>
vnoremap <Leader>rk y :%s/<C-r>"//gc<Left><Left><Left>

" Remove highlighting on escape
nmap <silent> <esc> :nohlsearch<cr>


" -----------    custom commands  ---------------
command! PackUpdate call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  call minpac#clean()
command! PackStatus call minpac#status()

" Quit help window just by q
augroup EndHelpQ | au! FileType help noremap <buffer> q :q<cr> | augroup END
augroup EndQuickFixQ | au! FileType qf noremap <buffer> q :q<cr> | augroup END

" Automatically source the vimrc file on save
augroup AutoSourcing
  autocmd!
  autocmd BufWritePost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim
augroup END



" Put quick fix under main window
"augroup DragQuickfixWindowDown
"    autocmd!
"    autocmd FileType qf wincmd J
"augroup end

" ---------------    tagbar   -------------------
call minpac#add('majutsushi/tagbar')
"let g:tagbar_autoshowtag = 1
let g:tagbar_autoclose = 0
let g:tagbar_autofocus = 1
let g:tagbar_autopreview = 0
let g:tagbar_compact = 1
let g:tagbar_left = 1

nmap <F3> :TagbarToggle<CR>

" -------------    vim-gutter  ------------------
call minpac#add('airblade/vim-gitgutter')
let g:gitgutter_map_keys = 0

nnoremap <leader>gp :silent! GitGutterPreviewHunk<cr>
nnoremap <leader>go :pclose<cr>
nnoremap <leader>tg :GitGutterToggle<cr>

"nmap [c <Plug>GitGutterPrevHunk
"nmap ]c <Plug>GitGutterNextHunk

"function! PreviewWindowOpened()
    "for nr in range(1, winnr('$'))
        "if getwinvar(nr, '&pvw') == 1
             "found a preview
            "return 1
        "endif
    "endfor
    "return 0
"endfunction

" --------------  vim.fugitive   ----------------
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-rhubarb')
let g:github_enterprise_urls = ['https://github-fm.intra.douban.com']


" ------------    ranger.vim   ------------------
call minpac#add('francoiscabrol/ranger.vim')
call minpac#add('rbgrouleff/bclose.vim')

nmap <F2> :Ranger<cr>
nmap <leader>ft :RangerWorkingDirectory<cr>
nmap <leader>fo :RangerCurrentFile<cr>
let g:ranger_map_keys = 0
let g:ranger_replace_netrw = 1

" --------------   vim-devicons  ----------------
call minpac#add('ryanoasis/vim-devicons')
let g:airline_powerline_fonts = 1
let g:codedark_conservative = 1

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



" ------------------  Denite  -------------------
call minpac#add('Shougo/denite.nvim')


" ------------------   CtrlP --------------------
"call minpac#add('ctrlpvim/ctrlp.vim')
"nmap <leader>ji :CtrlPBufTagAll<cr>
"nmap <leader>jt :CtrlPTag<cr>

"nmap <leader>ff :CtrlPCurFile<cr>

"set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
"set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows


"let g:ctrlp_match_window = 'results:30'
"let g:ctrlp_custom_ignore = {
  "\ 'dir':  '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$',
  "\ 'file': '\v(tags)|\.(exe|so|dll|pyc)$',
  "\ }

" ------------   easy motion  ----------------
call minpac#add('easymotion/vim-easymotion')

let g:EasyMotion_do_mapping = 0

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

" ---------------  neoterm -------------------
" call minpac#add('kassio/neoterm')

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

" ---------------  neoterm -------------------
call minpac#add('mhinz/neovim-remote')

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

" ---------------- vim-test ------------------
call minpac#add('janko/vim-test')

" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
nmap <silent> t<c-n> :TestNearest<cr>
nmap <silent> t<c-f> :TestFile<cr>
nmap <silent> t<c-s> :TestSuite<cr>
nmap <silent> t<c-l> :TestLast<cr>
nmap <silent> t<c-g> :TestVisit<cr>

"let test#strategy = 'neoterm'

" ---------------- LSP ------------------
call minpac#add('prabirshrestha/async.vim')
call minpac#add('prabirshrestha/vim-lsp')
call minpac#add('neoclide/coc.nvim', {'branch': 'release', 'do': 'yarn install --frozen-lockfile'})

" if hidden is not set, TextEdit might fail.
"set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
"set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

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
"inoremap <silent><expr> <c-space> coc#refresh()

"Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
"Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

 "Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>bf  <Plug>(coc-format)
nmap <leader>bf  <Plug>(coc-format)

augroup CocFormat
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

 "Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Using CocList
" Show all diagnostics
"nnoremap <silent> <leader>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
"nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
"nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <leader>ji  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <leader>jt  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
"nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
"nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
"nnoremap <silent> <leader>p  :<C-u>CocListResume<CR>

nnoremap <silent> <leader>ay  :<C-u>CocList -A --normal yank<cr>

" ------------- NerdCommenter ----------------
call minpac#add('scrooloose/nerdcommenter')
let g:NERDCreateDefaultMappings = 0

nmap <leader>cl <plug>NERDCommenterInvert
vmap <leader>cl <plug>NERDCommenterInvert
nmap <leader>cp vip<plug>NERDCommenterInvert
vmap <leader>cp vip<plug>NERDCommenterInvert

nmap <leader>cL <plug>NERDCommenterNested
vmap <leader>cL <plug>NERDCommenterNested
nmap <leader>cP vip<plug>NERDCommenterNested
vmap <leader>cP vip<plug>NERDCommenterNested

nmap <leader>cul <plug>NERDCommenterUncomment
vmap <leader>cul <plug>NERDCommenterUncomment
nmap <leader>cup vip<plug>NERDCommenterUncomment
vmap <leader>cup vip<plug>NERDCommenterUncomment

" ------------ better-whitespace -------------
call minpac#add('ntpeters/vim-better-whitespace')
let g:better_whitespace_enabled = 1

" ---------------- Starify -------------------
call minpac#add('mhinz/vim-startify')
" forbid to change directory
let g:startify_change_to_dir = 1

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

" xmap visual
" vmap visula and select
" omap operator pending
" lmap Insert, Command-line, Lang-Arg
" tmap Terminal-Job
" cmap Command-line
