#!/bin/bash
sudo apt update
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce -y
sudo docker pull selenium/hub
sudo docker pull selenium/node-chrome-debug
sudo docker pull selenium/node-firefox-debug
sudo docker pull selenium/node-firefox
sudo docker run -d -p 4444:4444 --name selenium-hub -P selenium/hub
sudo docker run -d -P --name chromeBro1 --link selenium-hub:hub selenium/node-chrome-debug
sudo docker run -d -P --name foxBro1 --link selenium-hub:hub selenium/node-firefox-debug