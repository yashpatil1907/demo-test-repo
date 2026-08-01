output "public_ip" {

  value = aws_instance.jenkins.public_ip

}

output "public_dns" {

  value = aws_instance.jenkins.public_dns

}

output "repository_name" {
  value = aws_ecr_repository.demo_app.name
}

output "repository_url" {
  value = aws_ecr_repository.demo_app.repository_url
}