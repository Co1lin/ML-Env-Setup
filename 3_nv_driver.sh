#!/bin/bash

set -x	# print commands and their arguments as they are executed
set -e	# exit immediately if anything you're running returns a non-zero return code

source proxy/en.sh

sudo apt install linux-headers-$(uname -r) -y
distribution=$(. /etc/os-release;echo $ID$VERSION_ID | sed -e 's/\.//g')
wget https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/cuda-$distribution.pin -P /tmp
sudo mv /tmp/cuda-$distribution.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo -E apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/7fa2af80.pub
echo "deb http://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64 /" | sudo tee /etc/apt/sources.list.d/cuda.list
sudo -E apt update
sudo -E apt -y install cuda-drivers

echo \
"
export PATH=/usr/local/cuda/bin:\$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:\$LD_LIBRARY_PATH" \
	>> ~/.zshrc

# sudo reboot