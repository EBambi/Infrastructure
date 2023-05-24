provider "aws" {
  region = "us-east-2"
}

resource "aws_security_group" "instance_sg" {
  name        = "Terraform-SG"
  description = "Security group for EC2 instances"

  # Allow SSH access from HOST IP
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["186.114.47.119/32"]
  }

  # Allow outbound traffic to all destinations
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "agent_one" {
  ami                    = "ami-024e6efaf93d85776"
  instance_type          = "t2.micro"
  key_name               = "worker"
  security_groups        = [aws_security_group.instance_sg.id]
  subnet_id              = "subnet-024051aa739d8f921"
  count                  = 1
  tags = {
    Name = "agent-onne"
  }
}

resource "aws_instance" "agent_two" {
  ami                    = "ami-024e6efaf93d85776"
  instance_type          = "t2.micro"
  key_name               = "worker"
  security_groups        = [aws_security_group.instance_sg.id]
  subnet_id              = "subnet-024051aa739d8f921"
  count                  = 1
  tags = {
    Name = "agent-two"
  }
}

resource "aws_instance" "go_server" {
  ami                    = "ami-024e6efaf93d85776"
  instance_type          = "t2.micro"
  key_name               = "worker"
  security_groups        = [aws_security_group.instance_sg.id]
  subnet_id              = "subnet-024051aa739d8f921"
  count                  = 1
  tags = {
    Name = "Go-Server"
  }
}

resource "aws_iam_role" "terraform_admin" {
  name = "TerraformAdmin"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "terraform_admin_policy_attachment" {
  role       = aws_iam_role.terraform_admin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
