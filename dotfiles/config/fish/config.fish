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

set -e fish_user_paths
set -e CPPFLAGS
set -e LDFLAGS

# ruby
set -g fish_user_paths "/usr/local/opt/ruby/bin $fish_user_paths"
set -g fish_user_paths "$HOME/.gem/ruby/2.6.0/bin $fish_user_paths"

# fzf
set -gx FZF_DEFAULT_COMMAND "rg --files"
set -gx FZF_DEFAULT_OPTS "--preview='pistol {}'"

# mysql5.7
set -gx LDFLAGS "-L/usr/local/opt/mysql@5.7/lib $LDFLAGS"
set -gx CPPFLAGS "-I/usr/local/opt/mysql@5.7/include $CPPFLAGS"
set -gx fish_user_paths "/usr/local/opt/mysql@5.7/bin $fish_user_paths"

# openssl
set -gx fish_user_paths "/usr/local/opt/openssl/bin $fish_user_paths"

set -gx LDFLAGS "-L/usr/local/opt/openssl/lib $LDFLAGS"
set -gx CPPFLAGS "-I/usr/local/opt/openssl/include $CPPFLAGS"
set -gx PKG_CONFIG_PATH "/usr/local/opt/openssl/lib/pkgconfig"

# zlib
set -gx LDFLAGS "-L/usr/local/opt/zlib/lib $LDFLAGS"
set -gx CPPFLAGS "-I/usr/local/opt/zlib/include $CPPFLAGS"

# bzip2
set -gx LDFLAGS "-L/usr/local/opt/bzip2/lib $LDFLAGS"
set -gx CPPFLAGS "-I/usr/local/opt/bzip2/include $CPPFLAGS"

# pipenv
set -gx WORKON_HOME ~/.venvs
# set -e PIPENV_VENV_IN_PROJECT
set -gx PIPENV_SKIP_LOCK 1
set -gx PIPENV_VERBOSITY -1
set -gx PIPENV_PYPI_MIRROR https://pypi.douban.com/simple

set -gx RANGER_LOAD_DEFAULT_RC 0

# 使用trash替换rm命令
alias rm trash

# rg configuration
set -gx RIPGREP_CONFIG_PATH "$HOME/.ripgreprc"

# n configuration
# set -gx N_PREFIX "$HOME/.n"
# set -gx fish_user_paths "$HOME/.n/bin $fish_user_paths"
# set -gx N_NODE_MIRROR "https://npm.taobao.org/mirrors/node"

# /usr/loca/bin and ~/bin
set -g fish_user_paths "$HOME/go/bin $fish_user_paths"
set -g fish_user_paths "$HOME/bin $fish_user_paths"

# pyenv
source (pyenv init - | psub)

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
