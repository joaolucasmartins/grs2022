sudo ip a a 192.168.88.100/24 dev ens19
sudo ip link set ens19 up
sudo sysctl -w net.ipv4.ip_forward=1 
sudo iptables -t nat -A POSTROUTING -s 192.168.88.101 -o eth0 -j MASQUERADE
