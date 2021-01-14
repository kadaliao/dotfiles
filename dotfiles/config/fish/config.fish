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

# for devicon in vim to work
set -gx LANG "en_US.UTF-8"

set -e fish_user_paths
set -e CPPFLAGS
set -e LDFLAGS

# ruby
set -p fish_user_paths "/usr/local/opt/ruby/bin"
set -p fish_user_paths "$HOME/.gem/ruby/2.6.0/bin"

# fzf
set -p FZF_DEFAULT_COMMAND "rg --files"
set -p FZF_DEFAULT_OPTS "--preview='pistol {}'"

# mysql5.7
# set -p LDFLAGS "-L/usr/local/opt/mysql@5.7/lib"
# set -p CPPFLAGS "-I/usr/local/opt/mysql@5.7/include"
# set -p fish_user_paths "/usr/local/opt/mysql@5.7/bin"


# set -gx LDFLAGS "-L/usr/local/opt/openssl@1.1/lib"
# set -gx CPPFLAGS "-I/usr/local/opt/openssl@1.1/include"
# set -gx PKG_CONFIG_PATH "/usr/local/opt/openssl@1.1/lib/pkgconfig"

# zlib and bzip2
# set -p LDFLAGS "-L/usr/local/opt/zlib/lib -L/usr/local/Cellar/bzip2/1.0.8/lib"

# pipenv
set -gx WORKON_HOME ~/.venvs
set -e PIPENV_VENV_IN_PROJECT
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
set -p fish_user_paths "$HOME/go/bin"
set -p fish_user_paths "$HOME/bin"

# pyenv
set -e PYENV_VERSION
status --is-interactive; and source (pyenv init -|psub)

# openssl
set -p fish_user_paths "/usr/local/opt/openssl@1.1/bin"

set -gx LDFLAGS "-L/usr/local/opt/openssl@1.1/lib"
set -gx CFLAGS "-I/usr/local/opt/openssl@1.1/include"
set -gx CPPFLAGS "-I/usr/local/opt/openssl@1.1/include"
set -gx PKG_CONFIG_PATH "/usr/local/opt/openssl@1.1/lib/pkgconfig"


# ffi
# set -gx LDFLAGS "-L/usr/local/opt/libffi/lib"
# set -gx CPPFLAGS "-I/usr/local/opt/libffi/include"
# set -gx PKG_CONFIG_PATH "/usr/local/opt/libffi/lib/pkgconfig"




test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
