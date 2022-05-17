#!/bin/sh

name="$1"

sudo rm -rf "/etc/docker/compose/${name}"
sudo mkdir -p "/etc/docker/compose/${name}"

sudo mv "$HOME/docker/"* "/etc/docker/compose/${name}"
