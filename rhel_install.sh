#!/bin/sh
TERRAFORM_VERSION=1.7.3
ANSIBLE_VERSION=2.16.2
GO_VERSION=1.22.2
sudo yum module enable -y container-tools:rhel8
sudo yum module install -y container-tools:rhel8
sudo dnf module enable nodejs:20 -y
sudo dnf install compat-lua-libs \
	libtermkey \
	libtree-sitter \
	libvterm \
	luajit \
	luajit2.1-luv \
	msgpack \
	unibilium \
	xsel \
	wget \
	tmux \
	vim \
	nodejs \
	util-linux-user \
	-y

wget https://github.com/neovim/neovim/releases/download/v0.9.5/nvim-linux64.tar.gz
sudo tar xvzf nvim-linux64.tar.gz && rm -rf nvim-linux64.tar.gz
sudo mv nvim-linux64/bin/nvim /usr/bin/nvim
sudo chmod +x /usr/bin/nvim

wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.22.2.linux-amd64.tar.gz
echo "export PATH=$PATH:/usr/local/go/bin" >~/.zshrc

if [ ! -d ~/.oh-my-zsh/ ]; then
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

### Configure zsh
cp config/zsh/gruvbox.zsh-theme ~/.oh-my-zsh/custom/themes/
cp config/zsh/zshrc ~/.zshrc

# Install pyenv
curl https://pyenv.run | bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >>~/.zshrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >>~/.zshrc
echo 'eval "$(pyenv init -)"' >>"$HOME/.zshrc"

# Install python 12
pyenv install 3.12.2
pyenv global 3.12.2

# Install pipx
python3 -m pip install --user pipx
python3 -m pipx ensurepath
sudo pipx ensurepath --global

# Install ansible
pipx install ansible-core=="$ANSIBLE_VERSION"
pipx install jmespath

# Install terraform
wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip
sudo mv terraform /usr/bin/terraform

APPS="nvim"

for i in $APPS; do
	if [ ! -d "$HOME/.config/$i" ]; then
		mkdir "$HOME/.config/$i"
	fi
	cp -r config/$APPS "$HOME/config/$i"
done

# Configure tmux
cp tmux.conf "$HOME/.tmux.conf"

chsh -s /bin/zsh
