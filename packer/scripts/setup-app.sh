#!/bin/bash
set -ex -o pipefail

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-compose

# set working environment
cd /home/ubuntu

# Get acme corp trader app
git clone https://github.com/guidomitolo/trader $APP_NAME
cd $APP_NAME

# place files
sudo cp /tmp/acmeapp.env /home/ubuntu/$APP_NAME/.env
sudo cp /tmp/acmeapp.service /etc/systemd/system/acmeapp.service

# Use `compose create` to fetch container data without starting the container
sudo docker compose create

sudo systemctl daemon-reload
sudo systemctl enable acmeapp