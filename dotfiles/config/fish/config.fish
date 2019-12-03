#在tmux中打开shell
# if status is-interactive
    # and not set -q TMUX
    # echo 'let\'s go tmux!'
    # exec tmux new -A -s Playground #创建或者附加指定session
# end

# 设置默认编辑器
set -gx EDITOR nvim
set -gx VISUAL nvim

set -gx GTAGSLABEL pygments

# fzf
set -gx FZF_DEFAULT_COMMAND "rg --files"

# mysql5.7
set -gx LDFLAGS "-L/usr/local/opt/mysql@5.7/lib"
set -gx CPPFLAGS "-I/usr/local/opt/mysql@5.7/include"
set -g fish_user_paths "/usr/local/opt/mysql@5.7/bin" $fish_user_paths

# openssl
set -gx LDFLAGS "-L/usr/local/opt/openssl/lib"
set -gx CPPFLAGS "-I/usr/local/opt/openssl/include"

# pipenv
# set -gx PIPENV_VENV_IN_PROJECT 1
set -e PIPENV_VENV_IN_PROJECT
set -gx PIPENV_SKIP_LOCK 1
set -gx PIPENV_PYPI_MIRROR https://pypi.tuna.tsinghua.edu.cn/simple

set -gx RANGER_LOAD_DEFAULT_RC 0

# 使用trash替换rm命令
alias rm trash

# ruby
set -g fish_user_paths "/usr/local/opt/ruby/bin" $fish_user_paths
set -g fish_user_paths "$HOME/.gem/ruby/2.6.0/bin" $fish_user_paths

# go-bin
set -g fish_user_paths "$HOME/go/bin" $fish_user_paths

# /usr/loca/bin and ~/bin
# set -g fish_user_paths "/usr/local/bin" $fish_user_paths
set -g fish_user_paths "$HOME/bin" $fish_user_paths

# rg configuration
set -gx RIPGREP_CONFIG_PATH "$HOME/.ripgreprc"
set -g fish_user_paths "/usr/local/opt/mysql@5.7/bin" $fish_user_paths

# n configuration
set -gx N_PREFIX "$HOME/.n"
set -gx fish_user_paths "$N_PREFIX/bin" $fish_user_paths
set -gx N_NODE_MIRROR "https://npm.taobao.org/mirrors/node"
