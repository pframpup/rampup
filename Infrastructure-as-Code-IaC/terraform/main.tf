
output "frontend_ip" {
  value = aws_instance.machine-frontend.private_ip
}
output "bastion_ip" {
  value = aws_instance.machine-bastion.private_ip
}
output "redis_ip" {
  value = aws_instance.machine-redis.private_ip
}

provider "aws" {
  region  = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_instance" "machine-bastion" {
  ami = var.ami
  instance_type = var.itype
  subnet_id = var.subnet_public
  key_name = var.key_pair_name
  associate_public_ip_address = true

  vpc_security_group_ids = [
    aws_security_group.secgroup-bastion.id
  ]

  tags = {
    Name = "bastion-server"
    project = var.tag_project
    responsible = var.tag_responsible
  }

  volume_tags = {
    project = var.tag_project
    responsible = var.tag_responsible
  }

  depends_on = [ aws_security_group.secgroup-bastion ]
}

resource "aws_instance" "machine-frontend" {
  ami = var.ami
  instance_type = var.itype
  subnet_id = var.subnet_public
  key_name = var.key_pair_name
  associate_public_ip_address = true

  vpc_security_group_ids = [
    aws_security_group.secgroup-frontend.id
  ]

  tags = {
    Name = "frontend-server"
    project = var.tag_project
    responsible = var.tag_responsible
  }

  volume_tags = {
    project = var.tag_project
    responsible = var.tag_responsible
  }

user_data = <<EOF
    #!/bin/bash
    set -ex
    yum -y update && yum -y upgrade
    yum -y group install "Development Tools"
    _d="/home/ec2-user"
    echo "export PORT=8080" >> $_d/env.sh
    echo "export AUTH_API_ADDRESS=http://${aws_instance.machine-go-java.private_ip}:8000" >> $_d/env.sh
    echo "export TODOS_API_ADDRESS=http://${aws_instance.machine-python-nodejs.private_ip}:8082" >> $_d/env.sh  
    source $_d/env.sh
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
    cd $_d/microservice-app-example/frontend/
    sudo npm install
    sudo npm run build
    nohup npm start &
  EOF

  depends_on = [ aws_security_group.secgroup-frontend ]
}

resource "aws_instance" "machine-redis" {
  ami = var.ami
  instance_type = var.itype
  subnet_id = var.subnet_private
  key_name = var.key_pair_name
  associate_public_ip_address = false

  vpc_security_group_ids = [
    aws_security_group.secgroup-redis.id
  ]

  tags = {
    Name = "redis-server"
    project = var.tag_project
    responsible = var.tag_responsible
  }

  volume_tags = {
    project = var.tag_project
    responsible = var.tag_responsible
  }

user_data = <<EOF
    #!/bin/bash
    set -ex
    yum -y update && yum -y upgrade
    yum -y group install "Development Tools"
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
	EOF

  depends_on = [ aws_security_group.secgroup-redis ]
}

resource "aws_instance" "machine-go-java" {

  ami = var.ami
  instance_type = var.itype
  subnet_id = var.subnet_private
  key_name = var.key_pair_name
  associate_public_ip_address = false

  vpc_security_group_ids = [
    aws_security_group.secgroup-go-java.id
  ]

  tags = {
    Name = "go-java-server"
    project = var.tag_project
    responsible = var.tag_responsible
  }

  volume_tags = {
    project = var.tag_project
    responsible = var.tag_responsible
  }

user_data = <<EOF
    #!/bin/bash
    set -ex
    yum -y update && sudo yum -y upgrade
    yum -y group install "Development Tools"
    _d="/home/ec2-user"
    echo "export GOPATH=$HOME/go" >> $_d/env.sh
    echo "export GOCACHE=$HOME/go/cache" >> $_d/env.sh
    echo "export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin" >> $_d/env.sh
    echo "export GO111MODULE=on" >> $_d/env.sh
    echo "export JWT_SECRET=PRFT" >> $_d/env.sh
    echo "export AUTH_API_PORT=8000" >> $_d/env.sh 
    echo "export USERS_API_ADDRESS=http://127.0.0.1:8083" >> $_d/env.sh
    echo "export SERVER_PORT=8083" >> $_d/env.sh 
    source $_d/env.sh
    if [ ! $(command -v go) ]; then
      wget -N https://go.dev/dl/go1.18.2.linux-amd64.tar.gz
      tar -C /usr/local -xzf $(pwd)/go1.18.2.linux-amd64.tar.gz
      echo -e 'export GOPATH=$HOME/go' >> /home/ec2-user/.bash_profile
      echo -e 'export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin' >> /home/ec2-user/.bash_profile
      echo -e 'export GO111MODULE=on' >> /home/ec2-user/.bash_profile
      source /home/ec2-user/.bash_profile
    fi
    yum -y install java-1.8.0-openjdk-devel
    if [ ! -d $_d/microservice-app-example ]; then
      cd $_d
      git clone https://github.com/bortizf/microservice-app-example.git
    fi
    cd $_d/microservice-app-example/auth-api
    /usr/local/go/bin/go mod init auth-api
    /usr/local/go/bin/go mod tidy
    /usr/local/go/bin/go build -buildvcs=false
    nohup ./auth-api &
    #runuser -l ec2-user -c '/bin/screen -dmS "GOAPP" ./auth-api'
    cd $_d/microservice-app-example/users-api
    ./mvnw clean install
    nohup  java -jar target/users-api-0.0.1-SNAPSHOT.jar &
    #runuser -l ec2-user -c '/bin/screen -dmS "JAVAPP" java -jar target/users-api-0.0.1-SNAPSHOT.jar'
	EOF

  depends_on = [ aws_security_group.secgroup-go-java ]
}

resource "aws_instance" "machine-python-nodejs" {

  ami = var.ami
  instance_type = var.itype
  subnet_id = var.subnet_private
  key_name = var.key_pair_name
  associate_public_ip_address = false

  vpc_security_group_ids = [
    aws_security_group.secgroup-python-nodejs.id
  ]

  tags = {
    Name = "python-nodejs-server"
    project = var.tag_project
    responsible = var.tag_responsible
  }

  volume_tags = {
    project = var.tag_project
    responsible = var.tag_responsible
  }

user_data = <<EOF
    #!/bin/bash
    set -ex
    yum -y update && yum -y upgrade
    yum -y group install "Development Tools"
    yum -y install openssl-devel
    _d="/home/ec2-user"
    echo "export REDIS_HOST=${aws_instance.machine-redis.private_ip}" >> $_d/env.sh
    echo "export REDIS_PORT=6379" >> $_d/env.sh 
    echo "export REDIS_CHANNEL=log_channel" >> $_d/env.sh
    echo "export JWT_SECRET=PRFT" >> $_d/env.sh 
    echo "export TODO_API_PORT=8082" >> $_d/env.sh 
    source $_d/env.sh
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
    cd $_d/microservice-app-example/log-message-processor/
    /usr/local/bin/pip3 install -r requirements.txt
    nohup /usr/local/bin/python3 main.py &
    cd $_d/microservice-app-example/todos-api/
    npm install
    nohup npm start &
	EOF

  depends_on = [ aws_security_group.secgroup-python-nodejs ]
}
