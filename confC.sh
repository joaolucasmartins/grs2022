#!/bin/bash

sudo ip link set ens19 up
sudo ip a a 10.0.1.200/24 dev ens19
sudo ip r a 10.0.2.0/24 via 10.0.1.254
# Install Docker
sudo ip route del default
sudo ip r a default via 192.168.88.100
sudo sed -i "s/nameserver 127.0.0.53/nameserver 8.8.8.8/g" /etc/resolv.conf
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo apt-get install -y docker-compose
sudo usermod -G docker -a theuser
sudo systemctl enable docker.service; sudo systemctl start docker.service
sudo systemctl enable containerd.service; sudo systemctl start containerd.service

# Run Nagios Server
sudo docker stop nagios
sudo docker rm nagios
docker build -t nagios ./nagios
docker run --name nagios -d -p 0.0.0.0:8080:80 nagios-c