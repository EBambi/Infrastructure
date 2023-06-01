terraform {
    backend "s3" {
      bucket            = "trfm-ste-bkt-final"
      key               = "global/s3/terraform.tfstate"
      region            = "us-east-2"

      dynamodb_table    = "terraform-lock"
      encrypt           = true
    }
    
}