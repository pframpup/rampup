#!/bin/sh
set -ex

sudo apt update && sudo apt -y upgrade

if [ ! $(command -v pip3) ]; then
  sudo apt-get -y install build-essential
  sudo apt-get -y install python3-pip
  sudo apt-get -y install zlib1g-dev
  sudo apt-get -y install libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev
fi

if [ ! $(command -v python3.6) ]; then
  cd /opt/
  sudo curl -LO https://www.python.org/ftp/python/3.6.3/Python-3.6.3.tgz
  sudo tar -zxvf Python-3.6.3.tgz
  cd Python-3.6.3
  sudo ./configure
  sudo make
  sudo make install
fi

if [ ! $(command -v node) ]; then
  cd /home/vagrant/
  curl -LO https://nodejs.org/download/release/v8.17.0/node-v8.17.0-linux-x64.tar.gz
  tar -xvzf node-v8.17.0-linux-x64.tar.gz
  cd node-v8.17.0-linux-x64/
  sudo ln -s $(pwd)/bin/node /bin/node
  sudo ln -s $(pwd)/bin/npm /bin/npm
  sudo ln -s $(pwd)/bin/npx /bin/npx
fi

sudo cp -R /vagrant_data/microservice-app-example-master/todos-api /home/vagrant/
sudo cp -R /vagrant_data/microservice-app-example-master/log-message-processor /home/vagrant
sudo cp -R /vagrant_data/microservice-app-example-master/frontend /home/vagrant

sudo chown -R $USER .

cd /home/vagrant/log-message-processor/
sudo pip3 install -r requirements.txt
REDIS_HOST=192.168.56.11 REDIS_PORT=6379 REDIS_CHANNEL=log_channel screen -S logmes-python -d -m bash -c 'python3 main.py'

cd /home/vagrant/todos-api/
npm install
JWT_SECRET=PRFT TODO_API_PORT=8082 screen -S todo-nodejs -d -m bash -c 'npm start'

cd /home/vagrant/frontend/
npm install
npm run build
PORT=8080 AUTH_API_ADDRESS=http://192.168.56.10:8000 TODOS_API_ADDRESS=http://192.168.56.12:8082 screen -S frontend -d -m bash -c 'npm start'

