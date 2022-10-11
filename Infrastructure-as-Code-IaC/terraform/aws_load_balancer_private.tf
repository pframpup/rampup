resource "aws_lb" "load-balancer-microservices-app-private" {
  name               = "microservice-app-lb-private"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.secgroup-alb-private.id]
  subnets            = [var.subnet_private-1, var.subnet_private-0]

  tags = {
    project = var.tag_project
    responsible = var.tag_responsible
  }
}

/*resource "aws_lb_listener" "http-redis" {
  load_balancer_arn = aws_lb.load-balancer-microservices-app-private.arn
  port              = "6379"
  protocol          = "HTTP"

  default_action {
    type = "forward"
      target_group_arn = aws_lb_target_group.tg-redis.arn   
  }
}*/

resource "aws_lb_listener" "http-auth-api" {
  load_balancer_arn = aws_lb.load-balancer-microservices-app-private.arn
  port              = "8000"
  protocol          = "HTTP"

  default_action {
    type = "forward"
      target_group_arn = aws_lb_target_group.tg-auth-api.arn
  }
}

resource "aws_lb_listener" "http-users-api" {
  load_balancer_arn = aws_lb.load-balancer-microservices-app-private.arn
  port              = "8083"
  protocol          = "HTTP"

  default_action {
    type = "forward"
      target_group_arn = aws_lb_target_group.tg-users-api.arn
  }
}

/*resource "aws_lb_listener" "http-log-message-processor" {
  load_balancer_arn = aws_lb.load-balancer-microservices-app-private.arn
  port              = "8009"
  protocol          = "HTTP"

  default_action {
    type = "forward"
      target_group_arn = aws_lb_target_group.tg-log-message-processor.arn
  }
}*/

resource "aws_lb_listener" "http-todos-api" {
  load_balancer_arn = aws_lb.load-balancer-microservices-app-private.arn
  port              = "8081"
  protocol          = "HTTP"

  default_action {
    type = "forward"
      target_group_arn = aws_lb_target_group.tg-todos-api.arn
  }
}



/*resource "aws_lb_listener" "http-private" {
  load_balancer_arn = aws_lb.load-balancer-microservices-app-private.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "forward"
    forward {
      target_group {
        arn    = aws_lb_target_group.tg-redis.arn
      }

      target_group {
        arn    = aws_lb_target_group.tg-auth-api.arn
      }

      target_group {
        arn    = aws_lb_target_group.tg-users-api.arn
      }

      target_group {
        arn    = aws_lb_target_group.tg-log-message-processor.arn
      }

      target_group {
        arn    = aws_lb_target_group.tg-todos-api.arn
      }
    }
  }

}*/


