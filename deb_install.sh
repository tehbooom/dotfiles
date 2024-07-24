#!/bin/bash
DIR=$(pwd)

## Setup terraform package
wget -O- https://apt.releases.hashicorp.com/gpg |
	gpg --dearmor |
	sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg >/dev/null

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" |
	sudo tee /etc/apt/sources.list.d/hashicorp.list

## Setup ansible packages
UBUNTU_CODENAME=jammy
wget -O- "https://keyserver.ubuntu.com/pks/lookup?fingerprint=on&op=get&search=0x6125E2A8C77F2818FB7BD15B93C4A3FD7BB9C367" | sudo gpg --dearmour -o /usr/share/keyrings/ansible-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/ansible-archive-keyring.gpg] http://ppa.launchpad.net/ansible/ansible/ubuntu $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/ansible.list

## Install deps
sudo apt update
sudo apt upgrade -y

sudo apt install -y gnupg \
	software-properties-common \
	zsh \
	git \
	ninja-build \
	gettext \
	cmake \
	unzip \
	curl \
	wget \
	jq \
	nodejs \
	npm \
	ansible \
	terraform \
	podman \
	python3-jmespath \
	python3-neovim \
	ruby-full \
	ripgrep \
	fd-find \
	tmux

## Install neovim
git clone https://github.com/neovim/neovim
cd neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo
ls
cd build
cpack -G DEB
sudo dpkg -i --force-overwrite nvim-linux64.deb
cd $DIR
rm -rf ~/neovim

## Install yq
sudo wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq
sudo chmod +x /usr/bin/yq

## Install GO and deps
wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.22.2.linux-amd64.tar.gz
rm -rf go1.22.2.linux-amd64.tar.gz
/usr/local/go/bin/go install github.com/jesseduffield/lazygit@latest

sudo npm install -g neovim
sudo npm install --global yarn
sudo npm install tree-sitter-cli

sudo gem install neovim
gem environment

mkdir ~/.config/
cp -r config/nvim "$HOME/.config/nvim"

# Configure tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cp tmux.conf "$HOME/.tmux.conf"

# Install oh-my-zsh
if [ ! -d ~/.oh-my-zsh/ ]; then
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

### Configure zsh
cp config/zsh/gruvbox.zsh-theme ~/.oh-my-zsh/custom/themes/
cp config/zsh/zshrc ~/.zshrc
