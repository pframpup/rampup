
resource "aws_lb" "load-balancer-microservices-app-public" {
  name               = "microservice-app-lb-public"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.secgroup-alb-public.id]
  subnets            = [var.subnet_public-1, var.subnet_public-0]

  //enable_cross_zone_load_balancing = true
  //enable_deletion_protection = true

  tags = {
    project = var.tag_project
    responsible = var.tag_responsible
  }
}


resource "aws_lb_listener" "http-public" {
  load_balancer_arn = aws_lb.load-balancer-microservices-app-public.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "forward"
    
    target_group_arn = aws_lb_target_group.tg-frontend.arn
    
  }
}
