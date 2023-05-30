variable "region" {
  type    = string
  default = "us-east-2"
}

variable "instance_AMI"{
    type        = string
    default     = "ami-0430580de6244e02e"
    description = "AMI of Ubuntu-srvr-20.04 LTS"
}

variable "instance_type"{
    type    = string
    default = "t2.micro"
}

variable "owner"{
    type    = string
    default = "Esteban"
}

variable "project"{
    type    = string
    default = "Final Project DevOps"
}

variable "key_name_workers"{
    type    = string
    default = "worker"
}