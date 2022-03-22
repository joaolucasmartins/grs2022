sudo ip link set ens19 up
sudo ip a a 10.0.1.200/24 dev ens19
sudo ip r a 10.0.2.0/24 via 10.0.1.254