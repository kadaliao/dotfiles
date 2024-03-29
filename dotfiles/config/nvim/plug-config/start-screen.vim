let g:startify_session_dir = '~/.config/nvim/session'

let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Files']            },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ ]

let g:startify_bookmarks = [
            \ { 'i': '~/.config/nvim/init.vim' },
            \ { 'z': '~/.zshrc' },
            \ '~/workspace',
            \ ]

" Automatically restart a session like this
let g:startify_session_autoload = 1

" Let Startify take care of buffers
let g:startify_session_delete_buffers = 1

" Similar to Vim-rooter
let g:startify_change_to_vcs_root = 1

" Unicode
let g:startify_fortune_use_unicode = 1

" Automatically Update Sessions
let g:startify_session_persistence = 1

" Get rid of empy buffer and quit
let g:startify_enable_special = 0


let g:startify_custom_header = [
                \ ' ██████╗ ██████╗ ██████╗ ███████╗██╗',
                \ '██╔════╝██╔═══██╗██╔══██╗██╔════╝██║',
                \ '██║     ██║   ██║██║  ██║█████╗  ██║',
                \ '██║     ██║   ██║██║  ██║██╔══╝  ╚═╝',
                \ '╚██████╗╚██████╔╝██████╔╝███████╗██╗',
                \ ' ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝╚═╝',
        \]
