#!/bin/bash

docker-compose -f server/docker-compose.yml up --build -d
docker exec server /bin/bash -c 'ip r del default via 10.0.2.1'
docker exec server /bin/bash -c 'ip r a default via 10.0.2.254'
docker network connect client_net dhcp-server --ip 10.0.1.2
docker network connect client_net squid --ip 10.0.1.253
docker exec squid ip r d default via 10.0.1.1
docker exec squid ip r a default via 10.0.1.254
docker network connect client_net client-proxy-test --ip 10.0.1.6
docker exec client-proxy-test ip r d default via 10.0.1.1
docker exec client-proxy-test ip r a default via 10.0.1.254
docker network create public_net subnet=172.31.255.0/24 --gateway=172.31.255.254
