#!/bin/bash
apt install --yes -- python3-venv neofetch
# Install oh-my-zsh
# Check if its installed first
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cp .config/zsh/gruvbox.zsh-theme ~/.oh-my-zsh/custom/themes/
