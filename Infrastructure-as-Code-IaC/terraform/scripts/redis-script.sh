 #!/bin/bash
set -ex
hostnamectl set-hostname ${hostname}
hostnamectl
yum -y update && yum -y upgrade
yum -y group install "Development Tools"
yum -y install nc
_d="/home/ec2-user"
if [ ! $(command -v redis-server) ]; then
  cd $_d
  yum -y install tcl
  wget -N https://download.redis.io/redis-stable.tar.gz
  tar -zxvf redis-stable.tar.gz
  cd $_d/redis-stable/src
  make
  #make test
  make install
fi
nohup /usr/local/bin/redis-server --protected-mode no &
