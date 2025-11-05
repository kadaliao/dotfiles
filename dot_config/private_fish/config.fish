#在tmux中打开shell

# Add Homebrew and other custom paths without duplicating
set -gx PATH /opt/homebrew/bin /opt/homebrew/sbin $HOME/.local/bin $PATH


# if status is-interactive
    # and not set -q TMUX
    # echo 'let\'s go tmux!'
    # exec tmux new -A -s Work #创建或者附加指定session
    # atuin init fish | source
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

set -gx XDG_CONFIG_DIRS "$HOME/.config"


[ -f /opt/homebrew/share/autojump/autojump.fish ]; and source /opt/homebrew/share/autojump/autojump.fish

# fzf
# set -gx FZF_DEFAULT_COMMAND "rg --files"

# 使用 fd 加速文件搜索
set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --exclude .git'

# 文件和图片预览
set -gx FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border --preview "bash -c \"if [[ -f {} ]]; then if file --mime {} | grep -q image/; then viu -w 40 -h 20 {}; else bat --style=numbers --color=always {} || head -200 {}; fi; fi\"" --preview-window=right:60%'

# 历史命令搜索增强
set -gx FZF_CTRL_R_OPTS '--sort --exact'

# mysql5.7
# set -p LDFLAGS "-L/usr/local/opt/mysql@5.7/lib"
# set -p CPPFLAGS "-I/usr/local/opt/mysql@5.7/include"
# set -p fish_user_paths "/usr/local/opt/mysql@5.7/bin"


# zlib and bzip2
# set -p LDFLAGS "-L/usr/local/opt/zlib/lib -L/usr/local/Cellar/bzip2/1.0.8/lib"

# libffi
# set -gx LDFLAGS "-L/opt/homebrew/opt/libffi/lib"
# set -gx CPPFLAGS "-I/opt/homebrew/opt/libffi/include"
# set -gx PKG_CONFIG_PATH "/opt/homebrew/opt/libffi/lib/pkgconfig"

# rg configuration
set -gx RIPGREP_CONFIG_PATH "$HOME/.ripgreprc"

# /usr/loca/bin
fish_add_path "$HOME/go/bin"

# go configuration
set -gx GOPATH (go env GOPATH)
set -gx GOBIN "$GOPATH/bin"


# consider using one line command:
# key=value echo $key

# openssl 1.1 on m1
# set -gx LDFLAGS "-L"(brew --prefix openssl@1.1)"/lib"
# set -gx CPPFLAGS "-I"(brew --prefix openssl@1.1)"/include"
# set -gx PKG_CONFIG_PATH (brew --prefix openssl@1.1)"/pkgconfig"


# librdkafka on m1
# set -gx C_INCLUDE_PATH "/opt/homebrew/Cellar/librdkafka/1.8.2/include"
# set -gx LIBRARY_PATH "/opt/homebrew/Cellar/librdkafka/1.8.2/lib"


# Douban
#set -gx SHIRE_DIR "$HOME/workspace/douban/shire"
#set -gx SSL_CERT_FILE '/etc/ssl/certs/ca-certificates.crt'
#set -gx REQUESTS_CA_BUNDLE '/etc/ssl/certs/ca-certificates.crt'


# Docker?
set -gx DOCKER_DEFAULT_PLATFORM 'linux/amd64'

abbr -a -- dpl 'dae pre list'
abbr -a -- dpd 'dae pre delete --pre'
abbr -a -- dpu 'dae pre update --pre'
abbr -a -- drsh 'dae remoteshell --pre'
abbr -a -- drs 'dae runscript --pre'
abbr -a -- dpc 'dae pre create --keep-days 30 --external'

# ruby
# set -p fish_user_paths "$HOME/.gem/ruby/2.7.0/bin"
fish_add_path "$HOME/.gem/ruby/2.7.0/bin"

# trash-cli
fish_add_path /opt/homebrew/opt/trash/bin

# fnm
if type -q fnm
  eval (fnm env)
end

# starship prompt
if type -q starship
    eval (starship init fish)
end

