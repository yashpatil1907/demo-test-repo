resource "aws_ecs_service" "demo" {


  name = "demo-service"


  cluster = aws_ecs_cluster.demo.id


  task_definition = aws_ecs_task_definition.demo.arn


  desired_count = 1


  launch_type = "EC2"


  deployment_minimum_healthy_percent = 50


  deployment_maximum_percent = 200


}