#!/bin/bash

docker build -t router-img .
docker run -d --net client_net --ip 10.0.1.254 --cap-add=NET_ADMIN --name router router-img
docker network connect server_net router --ip 10.0.2.254
docker network connect public_net router --ip 172.31.255.253
docker network disconnect public_net router
docker network connect dmz_net router --ip 172.16.123.142
docker exec router /bin/bash -c 'ip r d default via 10.0.1.1'
docker exec router /bin/bash -c 'ip r a default via 172.16.123.139'