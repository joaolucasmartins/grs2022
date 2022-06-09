#!/bin/sh

# if docker and compose are installed =>  skip install
command -v docker >/dev/null &&
  command -v docker-compose >/dev/null &&
  echo "Docker and docker-compose are already installed. Skipping..." &&
  exit 0

# remove old docker versions
sudo apt-get -y remove docker docker-engine docker.io containerd runc

# deps
sudo apt-get -y update
sudo apt-get -y install \
	ca-certificates \
	curl \
	gnupg \
	lsb-release

# docker official gpg key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# docker stable repo
echo \
	"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

# install docker engine
sudo apt-get -y update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io

# Add user to docker group
sudo usermod -G docker -a theuser

# compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# test docker
echo "Testing docker installation"
sudo docker version

# test docker-compose
echo "Testing docker compose installation"
sudo docker-compose version
