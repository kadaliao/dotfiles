" Install neovim in specified virtualenv
if empty(glob('~/.cache/vim/venv/neovim3/bin/python'))
	!python3 -m venv ~/.cache/vim/venv/neovim3
	!~/.cache/vim/venv/neovim3/bin/pip install neovim jedi
endif

" Python host for neovim
let g:python3_host_prog = '~/.cache/vim/venv/neovim3/bin/python'

" let g:python3_host_prog = expand("<path to python with pynvim installed>")
" let g:python3_host_prog = expand("~/.miniconda/envs/neovim/bin/python3.8") " <- example

" let g:node_host_prog = expand("<path to node with neovim installed>")
" let g:node_host_prog = expand("~/.nvm/versions/node/v12.16.1/bin/node") " <- example
