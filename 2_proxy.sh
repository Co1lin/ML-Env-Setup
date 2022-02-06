#!/bin/bash

set -x	# print commands and their arguments as they are executed
set -e	# exit immediately if anything you're running returns a non-zero return code

# configure proxy by docker
docker pull registry.cn-beijing.aliyuncs.com/co1lin/network:latest
PORT=19000
docker run -d -p $PORT:1087 --name network --restart=always -v ~/proxy:/etc/v2ray registry.cn-beijing.aliyuncs.com/co1lin/network:latest
echo "PORT=19000
export HTTP_PROXY=http://localhost:\$PORT
export HTTPS_PROXY=http://localhost:\$PORT
export ALL_PROXY=http://localhost:\$PORT
export http_proxy=http://localhost:\$PORT
export https_proxy=http://localhost:\$PORT
export all_proxy=http://localhost:\$PORT" \
	> proxy/en.sh
source proxy/en.sh

# oh-my-zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

echo 'PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT+='"'"' %{$fg[cyan]%}[$PWD]%{$reset_color%} $(git_prompt_info)'"'"'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"' \
	> ~/.oh-my-zsh/themes/robbyrussell.zsh-theme

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

source ~/.zshrc

# add plugins into .zshrc
# extract  zsh-autosuggestions