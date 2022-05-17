#!/bin/sh

sudo mv "$HOME/docker-compose@.service" "/etc/systemd/system/docker-compose@.service"
sudo systemctl daemon-reload
