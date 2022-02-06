#!/bin/bash

set -x	# print commands and their arguments as they are executed
set -e	# exit immediately if anything you're running returns a non-zero return code

source proxy/en.sh

distribution=$(. /etc/os-release;echo $ID$VERSION_ID | sed -e 's/\.//g')
version=11.4
sudo -E add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/ /"
sudo -E apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/${distribution}/x86_64/7fa2af80.pub
wget https://developer.download.nvidia.com/compute/cuda/repos/${distribution}/x86_64/cuda-${distribution}.pin -P /tmp
sudo -E mv /tmp/cuda-${distribution}.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo -E apt update
sudo -E apt install -y cuda

echo '
export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH' \
	>> ~/.zshrc


# https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh