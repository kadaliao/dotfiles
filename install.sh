#!/usr/bin/env sh

# homebrew
if [ $(uname) == 'Darwin' ];then
	echo "Install for macOS"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

	# nerdfont
	brew tap homebrew/cask-fonts
	brew cask install font-hack-nerd-font

	# lastpass
	sudo cpan install Capture::Tiny
	brew install lastpass-cli

else
	echo "Install for linux..."
	git clone https://github.com/Homebrew/brew ~/.linuxbrew/Homebrew
	mkdir ~/.linuxbrew/bin
	ln -s ~/.linuxbrew/Homebrew/bin/brew ~/.linuxbrew/bin
	eval $(~/.linuxbrew/bin/brew shellenv)
	echo 'eval $(~/.linuxbrew/bin/brew shellenv)' >> ~/.bashrc
fi

brew install git wget htop tmux pipenv python3 go vim neovim coreutils psutils ranger fish nodejs npm yarn fzf rg ctags autojump fx fpp libmagic


# lazygit
brew install jesseduffield/lazygit/lazygit
brew install lazygit

python3 -m pip install powerline-status autopep8 flake8 pylint jedi neovim docopt tmuxp

# pistol
env GO111MODULE=on go get -u github.com/doronbehar/pistol/cmd/pistol

