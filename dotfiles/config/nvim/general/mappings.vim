" Better nav for omni complete
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

" Use alt + hjkl to resize windows
" nnoremap <M-j>    :resize -2<CR>
" nnoremap <M-k>    :resize +2<CR>
" nnoremap <M-h>    :vertical resize -2<CR>
" nnoremap <M-l>    :vertical resize +2<CR>

" I hate escape more than anything else
inoremap jk <Esc>
inoremap kj <Esc>

" TAB in general mode will move to text buffer
nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>

" Alternate way to save
nnoremap <Space>fs :w<CR>
" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Better window navigation
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l


" close buffer and quit all
nnoremap <Space>bd :bd<CR>
nnoremap <Space>bD :q!<CR>
nnoremap <Space>qq :qa<CR>
nnoremap <Space>qQ :qa!<CR>
nnoremap <Space>bp :bp<CR>
nnoremap <Space>bn :bn<CR>

nnoremap <Space>tp :tabp<CR>
nnoremap <Space>tn :tabn<CR>
nnoremap <Space>td :tabclose<CR>
nnoremap <Space>tD :tabclose!<CR>

" Quickly access init.vim
noremap <Space>fve :edit $MYVIMRC<CR>
nnoremap <Leader>fvs :source $MYVIMRC<CR>

" Remove highlighting on escape
nmap <silent> <Esc> :nohlsearch<CR>

""""""""""""""""""""""
"  Leader clipboard  "
""""""""""""""""""""""
vnoremap <Space>y "+y
vnoremap <Space>x "+x
vnoremap <Space>d "+d
vnoremap <Space>p "+p
vnoremap <Space>P "+P

nnoremap <Space>Y "+Y
nnoremap <Space>yy "+yy
nnoremap <Space>x "+x
nnoremap <Space>dd "+dd
nnoremap <Space>p "+p
nnoremap <Space>P "+P


""""""""""""""""""""""
"     format python  "
""""""""""""""""""""""
xmap <Space>bf  <Plug>(coc-format-selected)
nmap <Space>bf  <Plug>(coc-format-selected)
