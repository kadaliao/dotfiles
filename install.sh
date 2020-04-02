#!/usr/bin/env sh

# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew install git wget htop tmux pipenv python3 go vim neovim coreutils psutils ranger fish nodejs npm yarn fzf rg ctags autojump fx fpp libmagic

# nerdfont
brew tap homebrew/cask-fonts
brew cask install font-hack-nerd-font

# lazygit
brew install jesseduffield/lazygit/lazygit
brew install lazygit

pip install neovim

python3 -m pip install powerline-status autopep8 flake8 pylint jedi neovim docopt tmuxp

# pistol
env GO111MODULE=on go get -u github.com/doronbehar/pistol/cmd/pistol

# lastpass
sudo cpan install Capture::Tiny
brew install lastpass-cli
