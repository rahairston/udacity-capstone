#!/usr/bin/env bash


# Install Docker
if $(which docker | grep -q /usr/bin/docker)
then
echo Docker Already Installed!
else 
sudo apt-get update
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    socat

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io
fi

# Tell Docker to not use sudo
if $(id | grep -q docker)
then
echo Docker Permissions set properly!
else 
sudo usermod -aG docker $USER
fi

# Install minikube
if $(which minikube | grep -q /usr/bin/)
then
echo Minikube installed!
else 
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
sudo dpkg -i minikube_latest_amd64.deb
fi

# Start minikube
if $(minikube status | grep -q "not found")
then
minikube start
else 
echo Minikube is running!
fi

