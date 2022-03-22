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
sudo docker stop server router app1 app2 client
sudo docker rm server router app1 app2 client
sudo docker network rm client_net server_net
sudo docker network create -d macvlan --subnet=10.0.1.0/24 --gateway=10.0.1.1 -o parent=ens19 client_net
sudo ip l s ens19 up
sudo ip l s ens20 up
./server/run.sh
./client/run.sh
./router/run.sh
sudo ip a a 10.0.1.99/24 dev ens19
