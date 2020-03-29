#!/usr/bin/env sh

# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew install git wget htop tmux pipenv python3 vim neovim coreutils psutils ranger fish nodejs npm yarn fzf rg ctags autojump proximac fx fpp

# nerdfont
brew tap homebrew/cask-fonts
brew cask install font-hack-nerd-font

# lazygit
brew install jesseduffield/lazygit/lazygit
brew install lazygit

# pip
pip3 install powerline-status autopep8 flake8 pylint jedi neovim docopt tmuxp

# lastpass
sudo cpan install Capture::Tiny
brew install lastpass-cli
