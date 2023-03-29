#!/bin/bash
sudo apt-get update
sudo apt-get -y install docker.io
sudo docker pull amioss/app_petclinic:latest
sudo docker run -d --name appli -p 80:8080 amioss/app_petclinic:latest
