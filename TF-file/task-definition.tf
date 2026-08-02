resource "aws_ecs_task_definition" "demo" {
  family                   = "demo-task"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]

  cpu    = "256"
  memory = "512"

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "demo-container"
      image     = "876225478418.dkr.ecr.us-east-1.amazonaws.com/demo-repo:latest"
      essential = true

      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
    }
  ])
}