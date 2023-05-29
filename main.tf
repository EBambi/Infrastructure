provider "aws" {
  region = "us-east-2"
}

resource "aws_security_group" "jenkins_ecs_sg" {
  name        = "JenkinsECS-Security"
  description = "Security group for Jenkins ECS"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "jenkins_ec2" {
  ami           = "ami-08333bccc35d71140"
  instance_type = "t2.micro"
  key_name      = "jenkins-master" #Key ID
  vpc_security_group_ids = [aws_security_group.jenkins_ecs_sg.id]
  subnet_id     = "subnet-01b134ee94ea26b30"

  root_block_device {
    volume_size = 8 #Disk size in GB
  }

  user_data = <<-EOF
    #!/bin/bash
    echo "ECS_CLUSTER=${aws_ecs_cluster.jenkins_cluster.id}" >> /etc/ecs/ecs.config
    echo "ECS_ENABLE_TASK_IAM_ROLE=true" >> /etc/ecs/ecs.config
    echo "ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true" >> /etc/ecs/ecs.config

    start ecs
  EOF

  tags = {
    Name = "Jenkins-EC2"
  }
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole-UniqueName" #Unique name for the IAM role
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_ecs_task_definition" "jenkins_task" {
  family                   = "jenkins-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "bridge"

  requires_compatibilities = ["EC2"]

  cpu                      = 1024
  memory                   = 2048 #Memory in MB

  container_definitions = <<DEFINITION
  [
    {
      "name": "jenkins-container",
      "image": "jenkins/jenkins:lts-jdk11",
      "portMappings": [
        {
          "containerPort": 8080,
          "hostPort": 8080,
          "protocol": "tcp"
        }
      ],
      "essential": true
    }
  ]
  DEFINITION
}

resource "aws_ecs_cluster" "jenkins_cluster" {
  name = "jenkins-cluster"
}
