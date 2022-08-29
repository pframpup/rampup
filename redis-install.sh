#!/bin/sh
set -ex
sudo apt update && sudo apt -y upgrade
sudo apt-get -y install build-essential
sudo apt-get install -y pkg-config
#curl -LO https://download.redis.io/redis-stable.tar.gz

if [ ! $(command -v redis-server) ]; then
  sudo apt install tcl
  wget -N https://download.redis.io/redis-stable.tar.gz
  tar -zxvf redis-stable.tar.gz
  cd $(pwd)/redis-stable/
  sudo  make
  #make test
  sudo make install
fi

screen -S redislog -d -m bash -c 'redis-server --protected-mode no'
