resource "aws_codecommit_repository" "dev_repo" {
  repository_name = var.repo_name
  description     = "This is the Sample App Repository"
}