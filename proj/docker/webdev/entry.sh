#!/bin/sh

# enable DNS updates
resolvconf --enable-updates

# get IP, routes, and name servers from DHCP server
dhcpcd

# update DNS stuff
resolvconf -u
# overwrite resolv.conf because we can't link it
tee /etc/resolv.conf </run/resolvconf/resolv.conf >/dev/null

tail -f /dev/null
