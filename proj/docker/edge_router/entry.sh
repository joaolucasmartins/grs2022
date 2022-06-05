#!/bin/sh

dflt_gateway="$1"
dmz_network="$2"
internal_network="$3"
gateway="$4"
other_net="$5"
other_net_gateway="$6"

ip r del default
ip r add default via "$dflt_gateway"
ip r del "$dmz_network"

ip r add "$gateway" dev eth0
ip r add "$dmz_network" via "$gateway"
ip r add "$internal_network" via "$gateway"
ip r add "$other_net" via "$other_net_gateway"

tail -f "/dev/null"
