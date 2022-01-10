#在tmux中打开shell
# if status is-interactive
#     and not set -q TMUX
#     echo 'let\'s go tmux!'
#     exec tmux new -A -s Work #创建或者附加指定session
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

fish_add_path /opt/homebrew/bin

set -gx XDG_CONFIG_DIRS "$HOME/.config"

[ -f /opt/homebrew/share/autojump/autojump.fish ]; and source /opt/homebrew/share/autojump/autojump.fish

# ruby
set -p fish_user_paths "$HOME/.gem/ruby/2.7.0/bin"

# fzf
set -gx FZF_DEFAULT_COMMAND "rg --files"
set -gx FZF_DEFAULT_OPTS "--preview='pistol {}'"

# mysql5.7
# set -p LDFLAGS "-L/usr/local/opt/mysql@5.7/lib"
# set -p CPPFLAGS "-I/usr/local/opt/mysql@5.7/include"
# set -p fish_user_paths "/usr/local/opt/mysql@5.7/bin"


# zlib and bzip2
# set -p LDFLAGS "-L/usr/local/opt/zlib/lib -L/usr/local/Cellar/bzip2/1.0.8/lib"

set -gx RANGER_LOAD_DEFAULT_RC 0

# 使用trash替换rm命令
alias rm trash

# rg configuration
set -gx RIPGREP_CONFIG_PATH "$HOME/.ripgreprc"

# go configuration
set -gx GOPATH (go env GOPATH)
set -gx GOBIN "$GOPATH/bin"

# /usr/loca/bin and ~/bin
set -p fish_user_paths "$HOME/go/bin"
set -p fish_user_paths "$HOME/bin"

# pyenv
set -Ux PYENV_ROOT $HOME/.pyenv
set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths

pyenv init - | source
status is-login; and pyenv init --path | source

# consider using one line command:
# key=value echo $key

# openssl 1.1 on m1
# set -gx LDFLAGS "-L"(brew --prefix openssl@1.1)"/lib"
# set -gx CPPFLAGS "-I"(brew --prefix openssl@1.1)"/include"
# set -gx PKG_CONFIG_PATH (brew --prefix openssl@1.1)"/pkgconfig"

# librdkafka on m1
# set -gx C_INCLUDE_PATH "/opt/homebrew/Cellar/librdkafka/1.8.2/include"
# set -gx LIBRARY_PATH "/opt/homebrew/Cellar/librdkafka/1.8.2/lib"

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

# starship prompt
if type -q starship
    eval (starship init fish)
end
