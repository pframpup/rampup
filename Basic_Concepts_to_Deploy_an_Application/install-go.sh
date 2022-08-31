#!/bin/sh
#set -ex
sudo apt update && sudo apt -y upgrade
sudo apt-get -y install build-essential
#sudo curl -LO https://go.dev/dl/go1.18.2.linux-amd64.tar.gz
if [ ! $(command -v go) ]; then
 sudo wget -N https://go.dev/dl/go1.18.2.linux-amd64.tar.gz
 sudo tar -C /usr/local -xzf $(pwd)/go1.18.2.linux-amd64.tar.gz
 echo -e 'export GOPATH=$HOME/go' >> ~/.profile
 echo -e 'export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin' >> ~/.profile
 echo -e 'export GO111MODULE=on' >> ~/.profile
 source ~/.profile
fi
sudo apt-get -y install openjdk-8-jdk

sudo cp -R /vagrant_data/microservice-app-example-master/auth-api /home/vagrant/
sudo cp -R /vagrant_data/microservice-app-example-master/users-api /home/vagrant

sudo chown -R $USER .

cd /home/vagrant/auth-api
go mod init auth-api
go mod tidy
go build

screen -S auth-go -d -m bash -c 'WT_SECRET=PRFT AUTH_API_PORT=8000 USERS_API_ADDRESS=http://192.168.56.10:8083 ./auth-api'

cd /home/vagrant/users-api
sudo ./mvnw clean install

screen -S users-java -d -m bash -c 'JWT_SECRET=PRFT SERVER_PORT=8083 java -jar target/users-api-0.0.1-SNAPSHOT.jar'
