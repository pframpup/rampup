resource "aws_lb_target_group" "tg-bastion" {
  name     = "Bastion-Group"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc
  target_type = "instance"

}

resource "aws_lb_target_group" "tg-frontend" {
  name     = "Frontend-Group"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc
  target_type = "instance"

  /*health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }*/

  /*stickiness {
      type = "lb_cookie"
  }*/
}

resource "aws_lb_target_group" "tg-redis" {
  name     = "Redis-Group"
  port     = 6379
  protocol = "HTTP"
  vpc_id   = var.vpc
}

resource "aws_lb_target_group" "tg-auth-api" {
  name     = "Auth-api-Group"
  port     = 8000
  protocol = "HTTP"
  vpc_id   = var.vpc

  health_check {
    path                = "/login"
    protocol            = "HTTP"
    matcher             = "200-499"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group" "tg-users-api" {
  name     = "Users-api-Group"
  port     = 8083
  protocol = "HTTP"
  vpc_id   = var.vpc

  health_check {
    path                = "/users"
    protocol            = "HTTP"
    matcher             = "200-499"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}

/*resource "aws_lb_target_group" "tg-log-message-processor" {
  name     = "Log-message-processor-Group"
  port     = 8009
  protocol = "HTTP"
  vpc_id   = var.vpc

}*/

resource "aws_lb_target_group" "tg-todos-api" {
  name     = "Todos-api-Group"
  port     = 8082
  protocol = "HTTP"
  vpc_id   = var.vpc

  health_check {
    path                = "/todos"
    protocol            = "HTTP"
    matcher             = "200-499"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}

//Add a load balancer to an ec2-instance

/*resource "aws_lb_target_group_attachment" "tga-frontend" {
  target_group_arn = aws_lb_target_group.tg-frontend.arn
  target_id        = aws_instance.machine-frontend.id
  port             = 8080
}
resource "aws_lb_target_group_attachment" "tga-redis" {
  target_group_arn = aws_lb_target_group.tg-redis.arn
  target_id        = aws_instance.machine-redis.id
  port             = 6379
}
resource "aws_lb_target_group_attachment" "tga-auth-api" {
  target_group_arn = aws_lb_target_group.tg-auth-api.arn
  target_id        = aws_instance.machine-auth-api.id
  port             = 8000
}
resource "aws_lb_target_group_attachment" "tga-users-api" {
  target_group_arn = aws_lb_target_group.tg-users-api.arn
  target_id        = aws_instance.machine-users-api.id
  port             = 8083
}
resource "aws_lb_target_group_attachment" "tga-log-message-processor" {
  target_group_arn = aws_lb_target_group.tg-log-message-processor.arn
  target_id        = aws_instance.machine-log-message-processor.id
  port             = 80
}
resource "aws_lb_target_group_attachment" "tga-todos-api" {
  target_group_arn = aws_lb_target_group.tg-todos-api.arn
  target_id        = aws_instance.machine-todos-api.id
  port             = 8082
}*/