#!/bin/bash
set -ex

yum -y update
#amazon-linux-extras install -y epel
amazon-linux-extras install ansible2 -y
amazon-linux-extras install docker -y
service docker start
usermod -a -G docker ec2-user
#chkconfig docker on
ansible-galaxy collection install community.general
ansible-galaxy collection install community.docker

#yum install python3 python36-docker -y
pip3 install docker
pip3 install docker-compose

_d="/home/ec2-user"

echo -e 'export JWT_SECRET=PRFT' >> /etc/profile
echo -e 'export AUTH_API_PORT=8000' >> /etc/profile
echo -e 'export USERS_API_ADDRESS=http://${private-lb-dns}:8083' >> /etc/profile
echo -e 'export SERVER_PORT=8083' >> /etc/profile
echo -e 'export PORT=8080' >> /etc/profile
echo -e 'export AUTH_API_ADDRESS=http://${private-lb-dns}:8000' >> /etc/profile 
echo -e 'export TODOS_API_ADDRESS=http://${private-lb-dns}:8082' >> /etc/profile
echo -e 'export REDIS_HOST=${redis-ip}' >> /etc/profile
echo -e 'export REDIS_PORT=6379' >> /etc/profile
echo -e 'export REDIS_CHANNEL=log_channel' >> /etc/profile
echo -e 'export TODO_API_PORT=8082' >> /etc/profile

if [ ! -d $_d/ansiblepb ]; then
    cd $_d
    wget -N https://github.com/pframpup/rampup/raw/develop/ansiblepb.tar.gz
    tar -zxvf ansiblepb.tar.gz
fi

cd $_d/ansiblepb
#ansible-playbook ${ansiblename}
#ansible-playbook ${ansiblename} --extra-vars "JWT_SECRET=$JWT_SECRET AUTH_API_PORT=$AUTH_API_PORT USERS_API_ADDRESS=$USERS_API_ADDRESS SERVER_PORT=$SERVER_PORT PORT=$PORT AUTH_API_ADDRESS=$AUTH_API_ADDRESS TODOS_API_ADDRESS=$TODOS_API_ADDRESS REDIS_HOST=$REDIS_HOST REDIS_PORT=$REDIS_PORT REDIS_CHANNEL=$REDIS_CHANNEL TODO_API_PORT=$TODO_API_PORT"
ansible-playbook ${ansiblename} --extra-vars "JWT_SECRET=PRFT AUTH_API_PORT=8000 USERS_API_ADDRESS=http://${private-lb-dns}:8083 SERVER_PORT=8083 PORT=8080 AUTH_API_ADDRESS=http://${private-lb-dns}:8000 TODOS_API_ADDRESS=http://${private-lb-dns}:8082 REDIS_HOST=${redis-ip} REDIS_PORT=6379 REDIS_CHANNEL=log_channel TODO_API_PORT=8082"
