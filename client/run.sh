docker pull sitespeedio/browsertime
# sudo docker network create -d macvlan --subnet=10.0.1.0/24 --gateway=10.0.1.1 -o parent=ens19 client_net
docker run --name client -d --net client_net --ip 10.0.1.100 --cap-add=NET_ADMIN --shm-size=1g --rm -v "$(pwd)":/browsertime sitespeedio/browsertime -n 1 http://10.0.2.100

docker exec client /bin/bash -c 'ip r del default via 10.0.1.1'
docker exec client /bin/bash -c 'ip r a 10.0.2.0/24 via 10.0.1.254'
