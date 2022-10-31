#!/bin/bash
set -ex
hostnamectl set-hostname ${hostname}
hostnamectl
yum -y update && yum -y upgrade
yum -y group install "Development Tools"
yum -y install nc
_d="/home/ec2-user"
launch_service () {
    set -ex
    _f="/home/ec2-user"
    export JWT_SECRET=PRFT
    export PORT=8080
    export AUTH_API_PORT=8000 
    export USERS_API_ADDRESS=http://${private-lb-dns}:8083
    export SERVER_PORT=8083
    export AUTH_API_ADDRESS=http://${private-lb-dns}:8000 
    export TODOS_API_ADDRESS=http://${private-lb-dns}:8082
    cd $_f/microservice-app-example/frontend/
    sudo npm install
    sudo npm run build
    #sudo npm start
    su ec2-user -c 'PORT=8080 AUTH_API_ADDRESS=http://${private-lb-dns}:8000 TODOS_API_ADDRESS=http://${private-lb-dns}:8082 npm start &'
}

if [ ! $(command -v node) ]; then
    cd $_d
    curl -LO https://nodejs.org/download/release/v8.17.0/node-v8.17.0-linux-x64.tar.gz
    tar -xvzf node-v8.17.0-linux-x64.tar.gz
    ln -s $_d/node-v8.17.0-linux-x64/bin/node /bin/node
    ln -s $_d/node-v8.17.0-linux-x64/bin/npm /bin/npm
    ln -s $_d/node-v8.17.0-linux-x64/bin/npx /bin/npx
fi
if [ ! -d $_d/microservice-app-example ]; then
    cd $_d
    git clone https://github.com/bortizf/microservice-app-example.git
fi

export -f launch_service
nohup bash -c launch_service &