#!/bin/sh

echo "Disable automatic updates (so we can reliably install docker)"
#ssh vmb 'bash' <"../helper_scripts/disable-automatic-updates.sh"

echo "Config network"
ssh vmb 'bash' <"../helper_scripts/targetmachine_network.sh"

echo "Install docker"
ssh vmb 'bash' <"../helper_scripts/installdocker.sh"

echo "Setup docker compose service"
scp "../docker/docker-compose@.service" vmb:~
ssh vmb 'bash' <"../helper_scripts/setup_compose_service.sh"

echo "Copy docker containers to the machine"
scp -r "../docker/router" "../docker/webapp" "../docker/webapp_worker" "docker-compose.yml" vmb:~
ssh vmb 'bash' <"./setup_containers.sh"
