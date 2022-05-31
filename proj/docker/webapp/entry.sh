#!/bin/sh

ip_network="$1"
dflt_gateway="$2"

ip r del default
ip r add default via "$dflt_gateway"

ip r del "$ip_network"
ip r add "$dflt_gateway" dev eth0
ip r add "$ip_network" via "$dflt_gateway"

service nagios-nrpe-server start
/usr/sbin/nginx -g "daemon off;"
