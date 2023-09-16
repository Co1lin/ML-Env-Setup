#!/bin/bash

set -x	# print commands and their arguments as they are executed
set -e	# exit immediately if anything you're running returns a non-zero return code

# proxy  TODO change its contents!
# cp ./assets/proxy ~/.proxy
# cp ./assets/unproxy ~/.unproxy

# TODO  comment it if not needed!
# source ~/.proxy

# basis
sudo apt update
sudo apt install -y vim curl wget git tmux zsh htop net-tools nload iftop iotop

echo \
'unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim
set number
set mouse=a
" ref: https://stackoverflow.com/questions/234564/tab-key-4-spaces-and-auto-indent-after-curly-braces-in-vim
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
syntax on' \
	> ~/.vimrc

echo -e "set -g mouse on
set -g history-limit 50000" \
	> ~/.tmux.conf

sudo chsh -s $(which zsh) $(whoami)

# oh my zsh
rm -rf ~/.oh-my-zsh
yes | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# configurations of default theme of oh my zsh
# cp ~/.oh-my-zsh/themes/robbyrussell.zsh-theme ~/.oh-my-zsh/themes/robbyrussell.zsh-theme.bak
# cp ./assets/robbyrussell.zsh-theme ~/.oh-my-zsh/themes/robbyrussell.zsh-theme

# add zsh plugins
rm -rf ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
rm -rf ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

cp ./assets/zshrc ~/.zshrc
# zsh
# source ~/.zshrc

# p10k theme
rm -rf ~/powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo -e '\nsource ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
echo -e '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> ~/.zshrc
cp ./assets/p10k.zsh ~/.p10k.zsh
