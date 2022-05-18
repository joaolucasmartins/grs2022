#!/bin/sh

set -e

name="$1"
machine_ssh="$2"
containers="$3"

#echo "Disable automatic updates (so we can reliably install docker)"
#ssh vmb 'bash' <"../helper_scripts/disable-automatic-updates.sh"

echo "Config network"
ssh "$machine_ssh" 'bash' <"./common_scripts/targetmachine_network.sh"

echo "Install docker"
ssh "$machine_ssh" 'bash' <"./common_scripts/installdocker.sh"

echo "Setup docker compose service"
scp "./docker/docker-compose@.service" "$machine_ssh":~
ssh "$machine_ssh" 'bash' <"./common_scripts/setup_compose_service.sh"

echo "Copy docker containers to the machine"
PREV_IFS="$IFS"
IFS=":"
for container in $containers; do
	scp -r "./docker/${container}" "$machine_ssh":~/docker
done
IFS="$PREV_IFS"

echo "Configure machine from template"
python3 "./common_scripts/network_conf.py" "./${name}_machine/netarchitecture.json" "./${name}_machine/docker-compose_tpl.yml" |
	ssh "$machine_ssh" 'tee ~/docker/docker-compose.yml' >/dev/null

echo "Setup containers for usage"
ssh "$machine_ssh" sudo rm -rf "/etc/docker/compose/${name}"
ssh "$machine_ssh" sudo mkdir -p "/etc/docker/compose/${name}"
ssh "$machine_ssh" sudo mv "~/docker/"* "/etc/docker/compose/${name}"
