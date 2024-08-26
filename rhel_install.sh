#!/bin/sh
TERRAFORM_VERSION=1.7.3
GO_VERSION=1.22.2
DIR=$(pwd)

# Install deps
sudo dnf update -y
sudo dnf upgrade -y
sudo yum module enable -y container-tools:rhel8
sudo yum module install -y container-tools:rhel8
sudo dnf copr enable atim/lazygit -y
sudo dnf module enable nodejs:20 -y
sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y
sudo dnf upgrade -y
sudo yum update -y
sudo yum install snapd -y
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap
sudo dnf install -y \
  jq \
  python3.12 \
  wget \
  tmux \
  vim \
  nodejs \
  util-linux-user \
  ninja-build \
  libtool \
  autoconf \
  automake \
  cmake \
  gcc \
  gcc-c++ \
  make \
  pkgconfig \
  unzip \
  patch \
  gettext \
  curl \
  zlib-devel \
  bzip2 \
  bzip2-devel \
  readline-devel \
  sqlite \
  sqlite-devel \
  openssl-devel \
  tk-devel \
  libffi-devel xz-devel \
  ripgrep \
  fd-find \
  lazygit \
  json-c-devel \
  tar \
  gnupg2 \
  @ruby \
  perl \
  java-17-openjdk \
  php \
  php-cli \
  php-zip \
  php-json \
  ansible

# Build nvim
mkdir ~/lab/build -p
cd ~/lab/build
git clone https://github.com/neovim/neovim
cd ~/lab/build/neovim/
git checkout nightly
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
rm -rf ~/lab/build

cd $DIR

# NVIM deps
sudo npm install -g neovim
sudo npm install --global yarn
yarn global add tree-sitter-cli

# Install Go
wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.22.2.linux-amd64.tar.gz
mkdir ~/go

python3 -m pip install jmespath

# Install terraform
wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip
sudo mv terraform /usr/bin/terraform

cp -r config/nvim "$HOME/.config/nvim"

# Configure tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cp tmux.conf "$HOME/.tmux.conf"
cp config/bash/git_prompt.sh ~/.git_prompt.sh
cp config/bash/bashrc ~/.bashrc
