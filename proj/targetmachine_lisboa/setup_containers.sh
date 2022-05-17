#!/bin/sh

sudo rm -rf "/etc/docker/compose/lisboa"
sudo mkdir -p "/etc/docker/compose/lisboa"

sudo mv "$HOME/router" "$HOME/webapp" "$HOME/webapp_worker" "$HOME/docker-compose.yml" "/etc/docker/compose/lisboa"
