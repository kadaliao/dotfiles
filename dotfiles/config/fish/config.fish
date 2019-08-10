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
set -gx PIPENV_VENV_IN_PROJECT 1
set -gx PIPENV_SKIP_LOCK 1
set -gx PIPENV_PYPI_MIRROR https://pypi.tuna.tsinghua.edu.cn/simple

set -g fish_user_paths "/usr/local/opt/node@10/bin" $fish_user_paths
