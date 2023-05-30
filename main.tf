provider "aws" {
    region = var.region
}

resource "aws_instance" "agent_one" {
    ami             = var.instance_AMI
    instance_type   = var.instance_type
    key_name        = var.key_name_workers

    tags = {
        Name    = "agent-one"
        Owner   = var.owner
        Project = var.project
    }
}

resource "aws_instance" "deployer" {
    ami             = var.instance_AMI
    instance_type   = var.instance_type
    key_name        = var.key_name_workers

    tags = {
        Name    = "deployer"
        Owner   = var.owner
        Project = var.project
    }
}