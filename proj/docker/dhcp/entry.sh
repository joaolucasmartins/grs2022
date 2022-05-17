#!/bin/sh

sed -i "s/X.X.X./${1}/g" "/etc/dhcp/dhcpd.conf"

/usr/sbin/dhcpd -4 -f -d --no-pid -cf "/etc/dhcp/dhcpd.conf"
