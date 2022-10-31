 #!/bin/bash
set -ex
hostnamectl set-hostname ${hostname}
hostnamectl
yum -y update && yum -y upgrade
yum -y group install "Development Tools"
yum -y install nc
yum -y install openssl-devel
_d="/home/ec2-user"
launch_python_service () {
    set -ex
    _f="/home/ec2-user"
    export REDIS_HOST=${redis-ip}
    export REDIS_PORT=6379
    export REDIS_CHANNEL=log_channel
    export JWT_SECRET=PRFT
    export TODO_API_PORT=8082
    cd $_f/microservice-app-example/log-message-processor/
    /usr/local/bin/pip3 install -r requirements.txt
    #/usr/local/bin/python3 main.py
    su ec2-user -c 'REDIS_HOST=${redis-ip} REDIS_PORT=6379 REDIS_CHANNEL=log_channel /usr/local/bin/python3 main.py &'
}

if [ ! $(command -v pip3) ]; then
    yum -y install python-pip
    yum -y install python3-pip
    yum -y install zlib1g-dev
    yum -y install libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev
    pip3 install wheel
fi
if [ ! $(command -v python3.6) ]; then
    cd /opt/
    curl -LO https://www.python.org/ftp/python/3.6.3/Python-3.6.3.tgz
    tar -zxvf Python-3.6.3.tgz
    cd Python-3.6.3
    #./configure --enable-shared
    ./configure --prefix=/usr/local
    make
    make install
fi

if [ ! -d $_d/microservice-app-example ]; then
    cd $_d
    git clone https://github.com/bortizf/microservice-app-example.git
fi

export -f launch_python_service
nohup bash -c launch_python_service &