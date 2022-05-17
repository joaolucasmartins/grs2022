#!/bin/sh

sudo rm -rf "/etc/docker/compose/porto"
sudo mkdir -p "/etc/docker/compose/porto"

sudo mv "$HOME/dhcp" "$HOME/netubuntu" "$HOME/dns" "$HOME/docker-compose.yml" "/etc/docker/compose/porto"
