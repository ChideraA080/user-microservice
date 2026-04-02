# VPC ID (existing or default)
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

# Subnets for ECS + ALB
variable "subnets" {
  description = "List of subnet IDs"
  type        = list(string)
}

# Docker image on Docker Hub
variable "docker_image" {
  description = "Docker Hub image to deploy"
  type        = string
}