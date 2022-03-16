docker build -t router-img .
docker run -d --net client_net --ip 10.0.1.254 --cap-add=NET_ADMIN --name router router-img
docker network connect server_net router --ip 10.0.2.254
