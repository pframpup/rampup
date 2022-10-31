 #!/bin/bash
set -ex
hostnamectl set-hostname ${hostname}
hostnamectl
yum -y update && yum -y upgrade
yum -y group install "Development Tools"
yum -y install nc
yum -y install openssl-devel
_d="/home/ec2-user"

launch_node_service () {
    set -ex
    _f="/home/ec2-user"
    export JWT_SECRET=PRFT
    export TODO_API_PORT=8082
    export REDIS_HOST=${redis-ip}
    export REDIS_PORT=6379
    export REDIS_CHANNEL=log_channel
    
    cd $_f/microservice-app-example/todos-api/
    sudo npm install
    #sudo npm start
    su ec2-user -c 'JWT_SECRET=PRFT TODO_API_PORT=8082 npm start &'
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

export -f launch_node_service
nohup bash -c launch_python_service; launch_node_service &