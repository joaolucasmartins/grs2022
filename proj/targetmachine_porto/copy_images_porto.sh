#!/bin/sh

# Copy images to vmc
scp -r ../docker/netubuntu vmc:~
scp -r ../docker/dhcp vmc:~