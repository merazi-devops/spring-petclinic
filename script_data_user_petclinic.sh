#!/bin/bash
sudo apt-get update
sudo apt-get -y install docker.io
sudo docker pull amioss/app_test:6.0
sudo docker run -d --name appli -p 80:8080 -p 3306:3306 amioss/app_test:6.0
