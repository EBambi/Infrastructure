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