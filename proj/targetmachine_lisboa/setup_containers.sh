#!/bin/sh

sudo rm -rf "/etc/docker/compose/lisboa"
sudo mkdir -p "/etc/docker/compose/lisboa"

sudo mv "$HOME/docker/"* "/etc/docker/compose/lisboa"
