#!/bin/bash
sudo apt update
sudo apt-get install mysql-client -y
sudo apt install git -y
docker pull mysql
docker run -p 3306:3306 --name mysql-docker-local -e MYSQL_ROOT_PASSWORD=Password -d mysql:latest --bind-address=0.0.0.0
while ! mysqladmin ping --host=127.0.0.1 --silent; do
    sleep 1
done
git clone https://github.com/AwakenedViskasha/spring-petclinic
cd .\spring-petclinic\
git checkout 
sudo mysql --host=127.0.0.1 --port=3306 -u root -pPassword <user.sql
sudo mysql petclinic --host=127.0.0.1 --port=3306 -u root -pPassword <schemas.sql
sudo mysql petclinic --host=127.0.0.1 --port=3306 -u root -pPassword <data.sql