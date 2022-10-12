#!/bin/sh

# Delete existing installations
sudo apt-get remove docker docker-engine docker.io containerd runc

# Set up repos
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install docker engine
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Create docker group
$(sudo groupadd docker)

# Add yourself to group
sudo usermod -aG docker $USER

# Activate changes
#newgrp docker

# Test docker installation
docker run hello-world

if [ $? -ne 0 ]
then
    echo "Docker installation failed"
fi