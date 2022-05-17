#!/bin/sh

# the following is an interactive command => not good
#sudo dpkg-reconfigure -plow unattended-upgrades
# small sed hack
sudo sed -i 's/1/0/g' /etc/apt/apt.conf.d/20auto-upgrades

sudo reboot
