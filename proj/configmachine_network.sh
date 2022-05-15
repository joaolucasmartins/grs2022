#!/bin/sh

sudo sysctl -w net.ipv4.ip_forward=1
sudo iptables -t nat -A POSTROUTING -s 192.168.88.101 -o eth0 -j MASQUERADE
sudo iptables -t nat -A POSTROUTING -s 192.168.88.102 -o eth0 -j MASQUERADE
