#!/bin/sh

gateway="$1"
lisbon_net="$2"
lisbon_gateway="$3"
porto_net="$4"
porto_gateway="$5"

ip r del default
ip r add default via "$gateway"

ip r add "$lisbon_net" via "$lisbon_gateway"
ip r add "$porto_net" via "$porto_gateway"

tail -f /dev/null
