#!/bin/bash
set -ex
yum -y update && sudo yum -y upgrade
yum -y group install "Development Tools"
yum -y install nc
_d="/home/ec2-user"

launch_java_service () {
    set -ex
    _f="/home/ec2-user"
    export JWT_SECRET=PRFT
    export SERVER_PORT=8083
    cd $_f/microservice-app-example/users-api
    ./mvnw clean install
    java -jar target/users-api-0.0.1-SNAPSHOT.jar
    #su ec2-user -c 'JWT_SECRET=PRFT SERVER_PORT=8083 java -jar target/users-api-0.0.1-SNAPSHOT.jar &'
}

yum -y install java-1.8.0-openjdk-devel
if [ ! -d $_d/microservice-app-example ]; then
    cd $_d
    git clone https://github.com/bortizf/microservice-app-example.git
fi

export -f launch_java_service
nohup bash -c launch_java_service &