#!/bin/sh

sed -i -e "s/X.X.X./${1}/g" -e "s/Y.Y.Y.Y/${2}/g" "/etc/dhcp/dhcpd.conf"

/usr/sbin/dhcpd -4 -f -d --no-pid -cf "/etc/dhcp/dhcpd.conf"
