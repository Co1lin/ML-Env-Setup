#!/bin/bash

set -x	# print commands and their arguments as they are executed
set -e	# exit immediately if anything you're running returns a non-zero return code

cp ./assets/proxy ~/.proxy
cp ./assets/unproxy ~/.unproxy

sudo apt update
sudo apt install -y vim git tmux zsh htop net-tools nload iftop iotop

echo 'set number
set mouse=a
" ref: https://stackoverflow.com/questions/234564/tab-key-4-spaces-and-auto-indent-after-curly-braces-in-vim
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab' \
	> ~/.vimrc

echo -e "set -g mouse on
	set -g history-limit 50000" \
	> ~/.tmux.conf

chsh -s /bin/zsh

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

cp ~/.oh-my-zsh/themes/robbyrussell.zsh-theme ~/.oh-my-zsh/themes/robbyrussell.zsh-theme.bak
cp ./assets/robbyrussell.zsh-theme ~/.oh-my-zsh/themes/robbyrussell.zsh-theme

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

cp ./assets/zshrc ~/.zshrc
source ~/.zshrc

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
cp ./assets/p10k.zsh ~/.p10k.zsh
