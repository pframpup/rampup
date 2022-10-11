
output "public_lb_dns" {
  value = aws_lb.load-balancer-microservices-app-public.dns_name
}
/*output "bastion_ip" {
  value = aws_instance.machine-bastion.private_ip
}
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