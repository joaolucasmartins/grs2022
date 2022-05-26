#!/bin/sh

dflt_gateway="$1"
dmz_ip="$2"
internal_network="$3"
gateway="$4"

ip r del default
ip r add default via "$dflt_gateway"

ip r del "$dmz_ip"
ip r add "$gateway" dev eth0
ip r add "$dmz_ip" via "$gateway"
ip r add "$internal_network" via "$gateway"

tail -f "/dev/null"
