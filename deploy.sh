#!/bin/bash

node_app=`docker ps -a | grep nodeapp | awk '{print $NF}'`
if [ $node_app=='nodeapp' ]; then
     echo "nodeapp is running, lets delete"
     docker rm -f nodeapp
fi
images=`docker images | grep sreddy9676/node | awk '{print $3}'`
docker rmi $images
docker run -d -p 9090:8080 --name=nodeapp $2
