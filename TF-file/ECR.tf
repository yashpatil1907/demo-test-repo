resource "aws_ecr_repository" "demo_app" {

  name = var.repository_name

  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "Demo-App-ECR-1"
    Environment = "Dev"
  }
}
 
qwe