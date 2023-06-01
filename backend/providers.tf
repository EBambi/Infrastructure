terraform {
    backend "s3" {
      bucket            = var.bucket_name
      key               = "global/s3/terraform.tfstate"
      region            = var.region

      dynamodb_table    = var.table_name
      encrypt           = true
    }
    
}