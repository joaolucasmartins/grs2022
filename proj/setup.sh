#!/bin/sh

set -e

name="$1"
machine_ssh="$2"
containers="$3"

#echo "Disable automatic updates (so we can reliably install docker)"
#ssh vmb 'bash' <"./common_scripts/disable-automatic-updates.sh"
#echo

echo "Config network"
ssh "$machine_ssh" 'bash' <"./common_scripts/targetmachine_network.sh"
echo

echo "Install rsync"
ssh "$machine_ssh" 'sudo apt-get -y install rsync'
echo

echo "Install docker"
ssh "$machine_ssh" 'bash' <"./common_scripts/installdocker.sh"
echo

echo "Setup docker compose service"
rsync "./docker/docker-compose@.service" "$machine_ssh":~
ssh "$machine_ssh" 'bash' <"./common_scripts/setup_compose_service.sh"
echo

echo "Copy docker containers to the machine"
PREV_IFS="$IFS"
IFS=":"
for container in $containers; do
  echo "Copying ${container}..."
	rsync -a -r --delete "./docker/${container}" "$machine_ssh":~/docker
done
IFS="$PREV_IFS"
echo

echo "Configure machine from template"
python3 "./common_scripts/network_conf.py" "./${name}_machine/netarchitecture.json" "./${name}_machine/docker-compose_tpl.yml" |
	ssh "$machine_ssh" 'tee ~/docker/docker-compose.yml' >/dev/null
echo

echo "Setup services' containers for deployment"
ssh "$machine_ssh" sudo rm -rf "/etc/docker/compose/${name}"
ssh "$machine_ssh" sudo mkdir -p "/etc/docker/compose/${name}"
# Note: name var intended client-side resolving
# Note: globbing server-side expanding
ssh "$machine_ssh" sudo mv "~/docker/"* "/etc/docker/compose/${name}"
