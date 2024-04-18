#!/bin/bash
# Alec Carpenter @tehbooom

brew tap FelixKratz/formulae
brew install ansible \
	btop \
	cmake \
	docker \
	go \
	neovim \
	node \
	pidof \
	python3.12 \
	koekeishiya/formulae/yabai \
	koekeishiya/formulae/skhd \
	sketchybar \
	spotify-tui spotifyd \
	terraform \
	tmux \
	tree \
	wget
APPS="alacritty btop nvim sketchybar skhd spotify-tui spotifyd yabai"

for i in $APPS; do
	if [ ! -d "$HOME/.config/$i" ]; then
		mkdir "$HOME/.config/$i"
	fi
	cp -r config/$APPS "$HOME/config/$i"
done

# Install oh-my-zsh
if [ ! -d ~/.oh-my-zsh/ ]; then
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
### Configure zsh
cp config/zsh/gruvbox.zsh-theme ~/.oh-my-zsh/custom/themes/
cp config/zsh/zshrc ~/.zshrc

# Configure tmux
cp tmux.conf "$HOME/.tmux.conf"
