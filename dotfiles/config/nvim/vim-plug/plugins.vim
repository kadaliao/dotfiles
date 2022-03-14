" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " Better Syntax Support
    " Plug 'sheerun/vim-polyglot'

    " Quoting/parenthesizing made simple
    Plug 'tpope/vim-surround'

    " Gruvbox theme
    Plug 'ellisonleao/gruvbox.nvim'
    " coc
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Airline
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Comment
    Plug 'tpope/vim-commentary'

    " Project management
    Plug 'mhinz/vim-startify'
    Plug 'mhinz/vim-signify'
    " Git
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'junegunn/gv.vim'

    " Which key
    Plug 'liuchengxu/vim-which-key'

    Plug 'honza/vim-snippets'
    Plug 'majutsushi/tagbar'

    " Ranger integration in vim and neovim, with dependency bclose
    Plug 'francoiscabrol/ranger.vim'
    Plug 'rbgrouleff/bclose.vim'
       
    " Create your own text objects
    Plug 'kana/vim-textobj-user'
    Plug 'kana/vim-textobj-line'
    Plug 'kana/vim-textobj-entire'
    Plug 'kana/vim-textobj-indent'

    " Text objects for the last searched pattern; i/
    Plug 'kana/vim-textobj-lastpat'

    Plug 'bps/vim-textobj-python'

    " Fuzzy file, buffer, mru, tag, etc finder.
    Plug 'ctrlpvim/ctrlp.vim'

    " A Vim plugin to colorize all text in the form #rrggbb or #rgb.
    Plug 'lilydjwg/colorizer'

    " Vim motions on speed
    Plug 'easymotion/vim-easymotion'

    " Vim plugin for insert mode completion of words in adjacent tmux panes
    Plug 'wellle/tmux-complete.vim'

    " make the yanked region apparent!
    Plug 'machakann/vim-highlightedyank'

    " A Vim plugin which shows git diff markers in the sign column and stages/previews/undoes hunks and partial hunks.
    Plug 'airblade/vim-gitgutter'

    " Plugin to toggle, display and navigate marks
    Plug 'kshenoy/vim-signature'
    
    " Seamless navigation between tmux panes and vim splits
    Plug 'christoomey/vim-tmux-navigator'

    " Provides an executable called nvr, Controlling nvim processes from the shell. E.g. opening files in another terminal window, Opening files from within :terminal without starting a nested nvim process.
    Plug 'mhinz/neovim-remote'

    " Adds file type icons to Vim plugins such as: NERDTree, vim-airline, CtrlP, unite, Denite, lightline, vim-startify and many more
    Plug 'ryanoasis/vim-devicons'

    " enable repeating supported plugin maps with "."
    Plug 'tpope/vim-repeat'

    " zoom split
    Plug 'dhruvasagar/vim-zoom'

    " An ack.vim alternative mimics Ctrl-Shift-F on Sublime Text 2
    Plug 'dyng/ctrlsf.vim'

call plug#end()

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
  \| endif
