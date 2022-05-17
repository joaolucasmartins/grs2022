#!/bin/sh

echo "Config network"
ssh vmc 'bash -s' < ../helper_scripts/targetmachine_network.sh

echo "Install docker"
ssh vmc 'bash -s' < ../helper_scripts/installdocker.sh

echo "Setup docker compose service"
scp "../docker/docker-compose@.service" vmc:~
ssh vmc 'bash' <"../helper_scripts/setup_compose_service.sh"

# Enable proxmox interface to create bridge with
# TODO Don't hardcode this interface
ssh vmc 'sudo ip link set ens19 up'

# Copy images to vmc
ssh vmc 'rm -r ~/netubuntu; rm -r ~/dhcp'
echo "wat"
scp -r ../docker/netubuntu vmc:/home/theuser/
scp -r ../docker/dhcp vmc:/home/theuser/

# Gen compose and copy to vmc
python3 network_conf.py netarchitecture.json docker-compose_tpl.yml | ssh vmc 'tee docker-compose.yml' > /dev/null

ssh vmc 'bash' <"./setup_containers.sh"
