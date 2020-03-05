#!/usr/bin/env sh

# homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install git wget htop tmux pipenv python2 python3 vim neovim coreutils psutils ranger fish nodejs npm yarn powerline fzf rg ctags autojump

# nerdfont
brew tap homebrew/cask-fonts
brew cask install font-hack-nerd-font

# pip
pip3 install autopep8 flake8 pylint jedi neovim docopt

# lastpass
sudo cpan install Capture::Tiny
brew install lastpass-cli
