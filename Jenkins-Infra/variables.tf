variable "region" {
  type    = string
  default = "us-east-2"
}

variable "instance_AMI"{
    type        = string
    default     = "ami-0047fa9cbdd32dd8f"
    description = "AMI of J-T-A which contains Jenkins, Terraform and AWS CLI"
}

variable "instance_type"{
    type    = string
    default = "t2.medium"
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