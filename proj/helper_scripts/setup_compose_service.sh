#!/bin/sh

sudo mv "$HOME/docker-compose@.service" "/etc/systemd/user/docker-compose@.service"
sudo systemctl daemon-reload
