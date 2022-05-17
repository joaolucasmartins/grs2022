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
ssh vmc 'bash -s' < 'sudo ip link set ens19 up'

# Copy images to vmc
scp -r ../docker/netubuntu vmc:~
scp -r ../docker/dhcp vmc:~
