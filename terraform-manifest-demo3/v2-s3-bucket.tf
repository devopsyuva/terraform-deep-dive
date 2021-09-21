resource "aws_s3_bucket" "name" {
    bucket = var.bucket_name
    acl    = "public-read"
    policy = <<EOF
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid":"PublicReadGetObject",
      "Effect":"Allow",
      "Principal": "*",
      "Action":["s3:GetObject","s3:GetObjectVersion"],
      "Resource":["arn:aws:s3:::${var.bucket_name}/*"]
    }
  ]
}
EOF
    versioning {
      enabled = true
    }
    website {
      index_document = "index.html"
      error_document = "error.html"
    } 
}