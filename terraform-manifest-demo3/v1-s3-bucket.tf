resource "aws_s3_bucket" "name" {
    bucket = var.bucket_name
    acl    = "public-read"
    policy = file("policy.json")
    versioning {
      enabled = true
    }
    website {
      index_document = "index.html"
      error_document = "error.html"
    } 
    tags = local.common_tags
}