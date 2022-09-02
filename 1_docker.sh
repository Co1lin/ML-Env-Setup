#!/bin/bash

set -x	# print commands and their arguments as they are executed
set -e	# exit immediately if anything you're running returns a non-zero return code

# install docker; ref: https://docs.docker.com/engine/install/ubuntu/
# sudo apt remove docker docker-engine docker.io containerd runc
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER
sudo service docker restart

# NVIDIA docker
# https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#setting-up-nvidia-container-toolkit
# distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
#       && curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
#       && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
#             sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
#             sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
# sudo apt-get update && sudo apt-get install -y nvidia-docker2
# sudo systemctl restart docker
