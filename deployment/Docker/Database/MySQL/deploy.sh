#!/bin/bash
sudo apt-get install mysql-client -y

sudo docker pull mysql
sudo docker run -p 3306:3306 --name mysql-docker-local -e MYSQL_ROOT_PASSWORD=Password -d mysql:latest --bind-address=0.0.0.0
while ! mysqladmin ping --host=127.0.0.1 --silent; do
    sleep 1
done

sudo mysql --host=127.0.0.1 --port=3306 -u root -pPassword <./deployment/Docker/Database/MySQL/user.sql
sudo mysql petclinic --host=127.0.0.1 --port=3306 -u root -pPassword <./deployment/Docker/Database/MySQL/schemas.sql
sudo mysql petclinic --host=127.0.0.1 --port=3306 -u root -pPassword <./deployment/Docker/Database/MySQL/data.sql