# docker build -t server-img .
# docker network create -d macvlan --subnet=10.0.2.0/24 --gateway=10.0.2.1 -o parent=ens20 server_net
# docker run -d --net server_net --ip 10.0.2.100 --cap-add=NET_ADMIN --name server server-img
docker-compose up -d
docker exec server /bin/bash -c 'ip r del default via 10.0.2.1'
docker exec server /bin/bash -c 'ip r a 10.0.1.0/24 via 10.0.2.254'
