variable "bucket_names" {
  description = "No of buckets that should be created"
  type        = map(string)
  default = {
    dev  = "s3-dev-bucket"
    test = "s3-test-bucket"
    qa   = "s3-qa-bucket"
  }
}