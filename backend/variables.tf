variable "bucket_name" {
  description = "The name of the S3 bucket. Must be globally unique."
  type        = string
  default     = "trfm-ste-bkt-Final"
}

variable "table_name" {
  description = "The name of the DynamoDB table."
  type        = string
  default     = "terraform-lock"
}