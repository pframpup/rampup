
output "public_lb_dns" {
  value = aws_lb.load-balancer-microservices-app-public.dns_name
}
output "bastion_ip" {
  value = aws_instance.machine-bastion.public_ip
}
/*
output "redis_ip" {
  value = aws_instance.machine-redis.private_ip
}
output "auth-api" {
  value = aws_instance.machine-auth-api.private_ip
}
output "users-api" {
  value = aws_instance.machine-users-api.private_ip
}
output "log-message-processor" {
  value = aws_instance.machine-log-message-processor.private_ip
}
output "todos-api" {
  value = aws_instance.machine-todos-api.private_ip
}*/

provider "aws" {
  region  = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_instance" "machine-bastion" {
  ami = var.ami
  instance_type = var.itype
  subnet_id = var.subnet_public-1
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

  user_data = <<EOF
    #!/bin/bash
    set -ex
    hostnamectl set-hostname bastion-machine
    hostnamectl
    #yum -y update && yum -y upgrade
    #yum -y group install "Development Tools"
    #amazon-linux-extras install -y ansible2
    #yum -y install java-1.8.0-openjdk
    amazon-linux-extras install java-openjdk11 -y
    wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
    rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
    yum -y install jenkins
    systemctl enable jenkins
    systemctl jenkins start
    #runuser -l ec2-user -c 'ansible-playbook playbook-frontend.yml'
    #pip3 install boto3
    #mkdir /home/ec2-user/.aws
    #echo -e '[default]' >> /home/ec2-user/.aws/cedentials
    #echo -e 'aws_access_key_id = <Your access key>' >> /home/ec2-user/.aws/cedentials
    #echo -e 'aws_secret_access_key = <Your secret key>' >> /home/ec2-user/.aws/cedentials
    #runuser -l ec2-user -c 'aws configure set aws_access_key_id ${var.access_key}'
    #runuser -l ec2-user -c 'aws configure set aws_secret_access_key ${var.secret_key}'
    #runuser -l ec2-user -c 'aws configure set default.region ${var.region}'
    #runuser -l ec2-user -c 'aws configure set output table'
    #runuser -l ec2-user -c 'python3 getEC2InstancesIP.py'
	EOF

  provisioner "local-exec" {
    command = "scp -o StrictHostKeyChecking=no -i ../aws-info/diego.puentes-rampup.pem ../aws-info/diego.puentes-rampup.pem ./ansiblepb.tar.gz  ./boto3/getEC2InstancesIP.py  ec2-user@$IPADDRESS:/home/ec2-user"

    environment = {
      IPADDRESS = aws_instance.machine-bastion.public_ip
    }
  }

  depends_on = [ aws_security_group.secgroup-bastion ]
}

resource "aws_instance" "machine-redis" {
  ami = var.ami
  instance_type = var.itype
  subnet_id = var.subnet_private-1
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

  /*user_data = <<EOF
    #!/bin/bash
    set -ex
    hostnamectl set-hostname redis-machine
    hostnamectl
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
*/

  user_data = base64encode(templatefile("./scripts/global-vars.sh", {
    private-lb-dns = aws_lb.load-balancer-microservices-app-private.dns_name,
    redis-ip = "localhost",
    ansiblename = "playbook-redis.yml"
  }))

  depends_on = [ aws_security_group.secgroup-redis ]
}