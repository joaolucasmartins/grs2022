#!/bin/sh

dmz_ip="$1"
gateway="$2"

ip r del default
ip r add default via "$gateway"

ip r del "$dmz_ip"
ip r add "$dmz_ip" dev eth0

# drop DHCP requests that attempt to leave the local network
#iptables -A INPUT -p udp --dport 67:68 -j DROP
#iptables -A FORWARD -p udp --dport 67:68 -j DROP
#iptables -A OUTPUT -p udp --dport 67:68 -j DROP
#iptables -A INPUT -p udp --sport 67:68 -j DROP
#iptables -A FORWARD -p udp --sport 67:68 -j DROP
#iptables -A OUTPUT -p udp --sport 67:68 -j DROP
#iptables -A INPUT -p tcp --dport 67:68 -j DROP
#iptables -A FORWARD -p tcp --dport 67:68 -j DROP
#iptables -A OUTPUT -p tcp --dport 67:68 -j DROP
#iptables -A INPUT -p tcp --sport 67:68 -j DROP
#iptables -A FORWARD -p tcp --sport 67:68 -j DROP
#iptables -A OUTPUT -p tcp --sport 67:68 -j DROP

tail -f "/dev/null"
