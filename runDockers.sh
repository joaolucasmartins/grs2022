sudo docker stop server router
sudo docker rm server router
sudo docker network rm client_net server_net
sudo docker network create -d macvlan --subnet=10.0.1.0/24 --gateway=10.0.1.1 -o parent=ens19 client_net
sudo ip l s ens19 up
sudo ip l s ens20 up
./server/run.sh
./client/run.sh
./router/run.sh
sudo ip a a 10.0.1.99/24 dev ens19