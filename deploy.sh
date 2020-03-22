#!/bin/bash

echo ""
echo "Welcome, You are executing a setup script bash for docker containers."
echo ""

docker pull tungduy/drone-demo:latest  
docker stop drone-demo  
docker rm drone-demo  
docker rmi tungduy/drone-demo:current  
docker tag tungduy/drone-demo:latest tungduy/drone-demo:current  
docker run -d --name drone-demo  --network fbeta-networks -p 3010:3010 -e PORT=3010 tungduy/drone-demo:latest 