# ALB DNS
output "alb_dns" {
  description = "The DNS of the Application Load Balancer"
  value       = aws_lb.alb.dns_name
}

# ECS Cluster Name
output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = aws_ecs_cluster.cluster.name
}

# ECS Service Name
output "ecs_service_name" {
  description = "Name of the ECS service"
  value       = aws_ecs_service.service.name
}