variable "region" {
  type        = string
  default     = "us-west-2"
  description = "Region where to deploy"
}

variable "bucket_name" {
  type        = string
  description = "Unique name for the bucket"
  default = "arun-cs-test-bucket"
}
