#!/bin/bash
# Alec Carpenter @tehbooom

## Install deps
echo "Installing deps"
sudo pacman -S neovim yarn npm go rust-analyzer
python3 -m pip install --user --upgrade pynvim
yay -S nvim-packer-git

## Install Vim Plug and Configure it
### Check if vim plug is already installed at ~/.local/share/nvim/site/autoload/plug.vim
if [ -f "~/.local/share/nvim/site/autoload/plug.vim" ]; then
    echo "Vim Plug already installed...skipping"
else
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    echo "Installed Vim Plug"
fi

## Configure Nvim
### Ensure the config directory exists if not create it
if [ ! -d "~/.config/nvim" ]; then
    mkdir ~/.config/nvim
fi

### Move config over and install the deps
cp ./nvim/init.vim ~/.config/nvim/
vim +'PlugInstall --sync' +qa
vim +':COQdeps' +qa
vim +':CHADdeps' +qa
echo "Configured neovim"

### Install LSPs
echo "Installing LSPs"
yarn global add yaml-language-server > /dev/null 2>&1
echo "Installed yaml LSP"
go install golang.org/x/tools/gopls@latest > /dev/null 2>&1
echo "Installed gopls"
git clone https://github.com/juliosueiras/terraform-lsp.git > /dev/null 2>&1
(cd terraform-lsp; GO111MODULE=on go mod download; make; make copy) > /dev/null 2>&1
rm -rf terraform-lsp
echo "Installed terraform-lsp"
go install github.com/nametake/golangci-lint-langserver@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
echo "Installed golangci-lint"

for i in @ansible/ansible-language-server dockerfile-language-server-nodejs bash-language-server vscode-langservers-extracted vim-language-server pyright
do
        sudo npm i -g $i > /dev/null 2>&1
        echo "Installed $i"
done

## Install oh-my-zsh
### Check if its installed first
if [ ! -d ~/.oh-my-zsh/ ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
### Configure zsh
cp ./zsh/gruvbox.zsh-theme ~/.oh-my-zsh/custom/themes/
cp ./zsh/zshrc ~/.zshrc

