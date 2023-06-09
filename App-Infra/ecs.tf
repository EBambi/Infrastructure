#ECS Task definition
resource "aws_ecs_task_definition" "sorter_app" {
  family                   = "sorter-app"
  cpu                      = 1024
  memory                   = 2048
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"

  container_definitions = <<DEFINITION
[
  {
    "image": "registry.gitlab.com/architect-io/artifacts/nodejs-hello-world:latest",
    "cpu": 1024,
    "memory": 2048,
    "name": "sorter-app",
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": 3000,
        "hostPort": 3000
      }
    ]
  }
]
DEFINITION
}

#Security group for ECS service
resource "aws_security_group" "sorter_task" {
  name        = "sorter-task-security-group"
  vpc_id      = "vpc-0864d6bf4075c3cd9"

  ingress {
    protocol        = "tcp"
    from_port       = 3000
    to_port         = 3000
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = "web-app-cluster"
}

#ECS Service with created task
resource "aws_ecs_service" "sorter_service" {
  name            = "sorter-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.sorter_app.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    security_groups   = [aws_security_group.sorter_task.id]
    subnets           = ["subnet-02c7900bcf6f3af6d"]
    assign_public_ip  = true
  }
}