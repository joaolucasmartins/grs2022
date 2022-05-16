#!/bin/sh

echo "Build docker images"
sudo docker build --tag router ~/router
sudo docker build --tag webapp ~/webapp/
sudo docker build --tag webapp_worker ~/webapp_worker