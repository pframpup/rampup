#!/bin/bash
set -ex

#echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
#echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
#sysctl -p
#echo "AddressFamily inet" >> /etc/ssh/sshd_config
#systemctl restart sshd
#sysctl -w net.ipv6.conf.all.disable_ipv6=1
#sysctl -w net.ipv6.conf.default.disable_ipv6=1
hostnamectl set-hostname ${hostname}
hostnamectl

yum -y update && sudo yum -y upgrade
yum -y group install "Development Tools"
yum -y install nc
_d="/home/ec2-user"
launch_go_service () {
    set -ex
    _f="/home/ec2-user"
    export GOPATH=$HOME/go
    export GOCACHE=$HOME/go/cache
    export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
    export GO111MODULE=on
    export JWT_SECRET=PRFT
    export AUTH_API_PORT=8000 
    export USERS_API_ADDRESS=http://${private-lb-dns}:8083
    export SERVER_PORT=8083
    cd $_f/microservice-app-example/auth-api
    /usr/local/go/bin/go mod init auth-api
    /usr/local/go/bin/go mod tidy
    /usr/local/go/bin/go build -buildvcs=false
    #./auth-api
    su ec2-user -c 'JWT_SECRET=PRFT AUTH_API_PORT=8000 USERS_API_ADDRESS=http://${private-lb-dns}:8083 ./auth-api &'
}

if [ ! $(command -v go) ]; then
    wget -N https://go.dev/dl/go1.18.2.linux-amd64.tar.gz
    tar -C /usr/local -xzf $(pwd)/go1.18.2.linux-amd64.tar.gz
    echo -e 'export GOPATH=$HOME/go' >> /home/ec2-user/.bash_profile
    echo -e 'export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin' >> /home/ec2-user/.bash_profile
    echo -e 'export GO111MODULE=on' >> /home/ec2-user/.bash_profile
    source /home/ec2-user/.bash_profile
fi

if [ ! -d $_d/microservice-app-example ]; then
    cd $_d
    git clone https://github.com/bortizf/microservice-app-example.git
fi

export -f launch_go_service
nohup bash -c launch_go_service &