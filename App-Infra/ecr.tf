#ECR Repository
resource "aws_ecr_repository" "app_repository" {
  name                 = "app-repository"
}