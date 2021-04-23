#!/usr/bin/env bash


# Note: This won't do anything if we are already deployed
echo "Initializing Deployment and Service"
minikube kubectl -- apply -f ~/udacity-capstone/.circleci/files/service.yml
minikube kubectl -- apply -f /tmp/modified_deployment.yml

echo "Rolling update!"
minikube kubectl -- rollout restart deployments/capstone-server

# Run socat to forward port 8080 to port 8080
if $(ps -A | grep -q socat)
then
echo "Port 8080 is already forwarded to 8080"
else
echo "Forwarding localhost port 8080 to the NodePort in Minikube server $(minikube service --url capstone-server)"
sudo nohup socat TCP-LISTEN:8080,fork TCP:$(minikube service --url capstone-server | sed -s "s|http://||g") >> /tmp/socat_logs &
fi
