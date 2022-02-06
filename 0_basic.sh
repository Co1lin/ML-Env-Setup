#!/bin/bash

set -x	# print commands and their arguments as they are executed
set -e	# exit immediately if anything you're running returns a non-zero return code

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