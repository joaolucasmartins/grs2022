#!/bin/bash

sudo sysctl net.ipv4.conf.all.forwarding=1
sudo iptables -P FORWARD ACCEPT
sudo ip route del default
sudo ip r a default via 192.168.88.100
sudo sed -i "s/nameserver 127.0.0.53/nameserver 8.8.8.8/g" /etc/resolv.conf
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo apt-get install -y docker-compose
sudo usermod -G docker -a theuser
sudo systemctl enable docker.service; sudo systemctl start docker.service
sudo systemctl enable containerd.service; sudo systemctl start containerd.service
sudo docker stop server router app1 app2 client client-proxy-test dhcp-server squid
sudo docker rm server router app1 app2 client client-proxy-test dhcp-server squid
sudo docker network rm client_net server_net
sudo docker network create -d macvlan --subnet=10.0.1.0/24 --gateway=10.0.1.1 -o parent=ens19 client_net
sudo docket network create -d macvlan --subnet=172.16.123.128/28 --gateway=172.16.123.140 -o parent=ens21 dmz_net
sudo ip l s ens19 up
sudo ip l s ens20 up
sudo ip l s ens21 up
./server/run.sh
./client/run.sh
./router/run.sh
sudo ip a a 10.0.1.99/24 dev ens19
sudo ip route add 172.16.123.128/28 via 172.31.255.253
sudo iptables -t nat -A POSTROUTING -s 172.16.123.128/28 -o eth0 -j MASQUERADE
sudo docker build -t netubuntu ~/netubuntu
sudo docker run -d --net public_net --ip 172.31.255.100 --cap-add=NET_ADMIN --name external_host netubuntu
sudo docker exec external_host /bin/bash -c 'ip r a default via 172.31.255.254'
sudo docker exec external_host /bin/bash -c 'ip r a 172.16.123.128/28 via 172.31.255.253'

# Router
sudo docker run -d --rm --net dmz_net --ip 172.16.123.139 --cap-add=NET_ADMIN --name edgerouter netubuntu
sudo docker network connect public_net edgerouter --ip 172.31.255.253
sudo docker exec edgerouter /bin/bash -c 'ip r d default via 172.16.123.140'
sudo docker exec edgerouter /bin/bash -c 'ip r a default via 172.31.255.254'
sudo docker exec edgerouter /bin/bash -c 'ip r a 10.0.0.0/8 via 172.16.123.142'
sudo docker exec edgerouter /bin/bash -c 'iptables -t nat -F; iptables -t filter -F'
sudo docker exec edgerouter /bin/bash -c 'iptables -t nat -A POSTROUTING -s 10.0.0.0/8 -o eth1 -j MASQUERADE'
sudo docker exec edgerouter /bin/bash -c 'iptables -P FORWARD DROP'
sudo docker exec edgerouter /bin/bash -c 'iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT'
sudo docker exec edgerouter /bin/bash -c 'iptables -A FORWARD -m state --state NEW -i eth0 -j ACCEPT'
sudo docker exec edgerouter /bin/bash -c 'iptables -A FORWARD -m state --state NEW -i eht1 -d 172.16.123.128/28 -j ACCEPT'