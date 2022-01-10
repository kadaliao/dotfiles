#!/usr/bin/env sh

# homebrew
echo "Install homebrew "
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh

# nerdfont
brew tap homebrew/cask-fonts
brew cask install font-hack-nerd-font

brew install -v autojump


# brew install files
brew install -v git
brew install -v wget
brew install -v htop
brew install -v tmux
brew install -v go
brew install -v vim
brew install -v neovim
brew install -v coreutils
brew install -v psutils
brew install -v ranger
brew install -v fish
brew install -v nodejs
brew install -v npm
brew install -v yarn
brew install -v fzf
brew install -v rg
brew install -v ctags
brew install -v fx
brew install -v fpp
brew install -v libmagic
brew install -v glibc
brew install -v tig


# lazygit
brew install jesseduffield/lazygit/lazygit
brew install lazygit

python3 -m pip install virtualenv
python3 -m pip install powerline-status
python3 -m pip install autopep8
python3 -m pip install flake8
python3 -m pip install pylint
python3 -m pip install jedi
python3 -m pip install pyvim
python3 -m pip install psutil
python3 -m pip install docopt
python3 -m pip install tmuxp
python3 -m pip install ruamel.yaml
python3 -m pip install jinja2
