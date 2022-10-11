
resource "aws_launch_template" "template-machine-frontend" {
    instance_type = var.itype
    key_name = var.key_pair_name
    image_id = var.ami_id
    
    vpc_security_group_ids = [
        aws_security_group.secgroup-frontend.id
    ]

    tag_specifications {
        resource_type = "volume"

    tags = {
        project = var.tag_project
        responsible = var.tag_responsible
    }
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
        Name = "frontend-server"
        project = var.tag_project
        responsible = var.tag_responsible
    }
  }

  user_data = base64encode(templatefile("./scripts/frontend-script.sh", {
      private-lb-dns = aws_lb.load-balancer-microservices-app-private.dns_name
  }))

  depends_on = [ aws_security_group.secgroup-redis ]
}

/*resource "aws_launch_template" "template-machine-redis" {
    instance_type = var.itype
    key_name = var.key_pair_name
    image_id = var.ami_id
    
    vpc_security_group_ids = [
        aws_security_group.secgroup-redis.id
    ]

    tag_specifications {
        resource_type = "volume"

    tags = {
        project = var.tag_project
        responsible = var.tag_responsible
    }
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
        Name = "redis-server"
        project = var.tag_project
        responsible = var.tag_responsible
    }
  }

  user_data = base64encode(templatefile("./scripts/redis-script.sh",{
    private-lb-dns = aws_lb.load-balancer-microservices-app-private.dns_name
  }))

  depends_on = [ aws_security_group.secgroup-redis ]
}
*/

resource "aws_launch_template" "template-machine-auth-api" {
    instance_type = var.itype
    key_name = var.key_pair_name
    image_id = var.ami_id
    
    vpc_security_group_ids = [
        aws_security_group.secgroup-auth-api.id
    ]

    tag_specifications {
        resource_type = "volume"

    tags = {
        project = var.tag_project
        responsible = var.tag_responsible
    }
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
        Name = "auth-api-server"
        project = var.tag_project
        responsible = var.tag_responsible
    }
  }

  user_data = base64encode(templatefile("./scripts/auth-api-script.sh",{
    private-lb-dns = aws_lb.load-balancer-microservices-app-private.dns_name
  }))

  depends_on = [ aws_security_group.secgroup-auth-api ]
}

resource "aws_launch_template" "template-machine-users-api" {
    instance_type = var.itype
    key_name = var.key_pair_name
    image_id = var.ami_id
    
    vpc_security_group_ids = [
        aws_security_group.secgroup-users-api.id
    ]

    tag_specifications {
        resource_type = "volume"

    tags = {
        project = var.tag_project
        responsible = var.tag_responsible
    }
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
        Name = "users-api-server"
        project = var.tag_project
        responsible = var.tag_responsible
    }
  }

  user_data = base64encode(templatefile("./scripts/users-api-script.sh",{
    private-lb-dns = aws_lb.load-balancer-microservices-app-private.dns_name
  }))

  depends_on = [ aws_security_group.secgroup-users-api ]
}

resource "aws_launch_template" "template-machine-log-message-processor" {
    instance_type = var.itype
    key_name = var.key_pair_name
    image_id = var.ami_id
    
    vpc_security_group_ids = [
        aws_security_group.secgroup-log-message-processor.id
    ]

    tag_specifications {
        resource_type = "volume"

    tags = {
        project = var.tag_project
        responsible = var.tag_responsible
    }
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
        Name = "log-message-processor-server"
        project = var.tag_project
        responsible = var.tag_responsible
    }
  }

  user_data = base64encode(templatefile("./scripts/log-message-processor-script.sh",{
    private-lb-dns = aws_lb.load-balancer-microservices-app-private.dns_name,
    redis-ip = aws_instance.machine-redis.private_ip
  }))

  depends_on = [ aws_security_group.secgroup-log-message-processor ]
}

resource "aws_launch_template" "template-machine-todos-api" {
    instance_type = var.itype
    key_name = var.key_pair_name
    image_id = var.ami_id
    
    vpc_security_group_ids = [
        aws_security_group.secgroup-todos-api.id
    ]

    tag_specifications {
        resource_type = "volume"

    tags = {
        project = var.tag_project
        responsible = var.tag_responsible
    }
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
        Name = "todos-api-server"
        project = var.tag_project
        responsible = var.tag_responsible
    }
  }

  user_data = base64encode(templatefile("./scripts/todos-api-script.sh",{
    private-lb-dns = aws_lb.load-balancer-microservices-app-private.dns_name,
    redis-ip = aws_instance.machine-redis.private_ip
  }))

  depends_on = [ aws_security_group.secgroup-todos-api ]
}