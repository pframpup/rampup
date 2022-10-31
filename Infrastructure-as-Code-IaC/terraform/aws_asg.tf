
resource "aws_autoscaling_group" "machine-frontend" {
  max_size = 1
  min_size = 1
  desired_capacity = 1

  vpc_zone_identifier = [var.subnet_public-1, var.subnet_public-0]
  target_group_arns = [
    aws_lb_target_group.tg-frontend.arn]

  launch_template {
    id = aws_launch_template.template-machine-frontend.id
  }
  tags = [
    {
      Name = "frontend-server"
        project = var.tag_project
        responsible = var.tag_responsible
    }
  ]
}

/*resource "aws_autoscaling_group" "machine-redis" {
  max_size = 1
  min_size = 1
  desired_capacity = 1

  vpc_zone_identifier = [var.subnet_public-1, var.subnet_public-0]
  target_group_arns = [aws_lb_target_group.tg-redis.arn]

  launch_template {
    id = aws_launch_template.template-machine-redis.id
  }
  tags = [
    {
      Name = "redis-server"
        project = var.tag_project
        responsible = var.tag_responsible
    }
  ]
}*/

resource "aws_autoscaling_group" "machine-auth-api" {
  max_size = 1
  min_size = 1
  desired_capacity = 1

  //vpc_zone_identifier = [var.subnet_public-1, var.subnet_public-0]
   vpc_zone_identifier = [var.subnet_private-1, var.subnet_private-0]
  target_group_arns = [aws_lb_target_group.tg-auth-api.arn]

  launch_template {
    id = aws_launch_template.template-machine-auth-api.id
  }
  tags = [
    {
      Name = "auth-api-server"
        project = var.tag_project
        responsible = var.tag_responsible
    }
  ]
}

resource "aws_autoscaling_group" "machine-users-api" {
  max_size = 1
  min_size = 1
  desired_capacity = 1

  //vpc_zone_identifier = [var.subnet_public-1, var.subnet_public-0]
   vpc_zone_identifier = [var.subnet_private-1, var.subnet_private-0]
  target_group_arns = [aws_lb_target_group.tg-users-api.arn]

  launch_template {
    id = aws_launch_template.template-machine-users-api.id
  }
  tags = [
    {
      Name = "users-api-server"
        project = var.tag_project
        responsible = var.tag_responsible
    }
  ]
}

resource "aws_autoscaling_group" "machine-log-message-processor" {
  max_size = 1
  min_size = 1
  desired_capacity = 1

  //vpc_zone_identifier = [var.subnet_public-1, var.subnet_public-0]
   vpc_zone_identifier = [var.subnet_private-1, var.subnet_private-0]
  //target_group_arns = [aws_lb_target_group.tg-log-message-processor.arn]

  launch_template {
    id = aws_launch_template.template-machine-log-message-processor.id
  }
  
  tags = [
    {
      Name = "log-message-processor-server"
        project = var.tag_project
        responsible = var.tag_responsible
    }
  ]
}

resource "aws_autoscaling_group" "machine-todos-api" {
  max_size = 1
  min_size = 1
  desired_capacity = 1

  //vpc_zone_identifier = [var.subnet_public-1, var.subnet_public-0]
   vpc_zone_identifier = [var.subnet_private-1, var.subnet_private-0]
  target_group_arns = [aws_lb_target_group.tg-todos-api.arn]

  launch_template {
    id = aws_launch_template.template-machine-todos-api.id
  }
  tags = [
    {
      Name = "todos-api-server"
        project = var.tag_project
        responsible = var.tag_responsible
    }
  ]
}