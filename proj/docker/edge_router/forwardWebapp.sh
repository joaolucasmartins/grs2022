#!/bin/sh

rui_burro="$1"

# Port forwarding webapp
iptables -A PREROUTING -t nat -i eth1 -p tcp --dport 80 -j DNAT --to "$rui_burro":80
iptables -A FORWARD -p tcp -d "$rui_burro" --dport 80 -j ACCEPT
iptables -A PREROUTING -t nat -i eth1 -p tcp --dport 443 -j DNAT --to "$rui_burro":443
iptables -A FORWARD -p tcp -d "$rui_burro" --dport 443 -j ACCEPT

iptables -A PREROUTING -t nat -i eth2 -p tcp --dport 80 -j DNAT --to "$rui_burro":80
iptables -A FORWARD -p tcp -d "$rui_burro" --dport 80 -j ACCEPT
iptables -A PREROUTING -t nat -i eth2 -p tcp --dport 443 -j DNAT --to "$rui_burro":443
iptables -A FORWARD -p tcp -d "$rui_burro" --dport 443 -j ACCEPT
