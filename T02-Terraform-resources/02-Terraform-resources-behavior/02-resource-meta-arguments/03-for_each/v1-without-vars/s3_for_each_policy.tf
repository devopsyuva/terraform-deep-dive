/*
This configuration will create 3 s3 buckets which names
provided with key-value on AWS provider
*/
resource "aws_s3_bucket" "s3demobucket" {
  for_each = {
    dev  = "s3-demo-bucket"
    test = "s3-demo-bucket"
    qa   = "s3-demo-bucket"
  }
  bucket = "${each.key}-${each.value}"
  policy = <<POLICY
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid":"PublicReadGetObject",
      "Effect":"Allow",
      "Principal": "*",
      "Action":["s3:GetObject","s3:GetObjectVersion"],
      "Resource":["arn:aws:s3:::${each.key}-${each.value}/*"]
    }
  ]
}
POLICY

  tags = {
    Name      = "${each.key}-${each.value}"
    Eachvalue = "${each.value}"
    Eachkey   = "${each.key}"
  }
}

resource "aws_s3_bucket_acl" "example_bucket_acl" {
  for_each = {for k, v in aws_s3_bucket.s3demobucket : k => v.id}
  # [for <KEY>, <VALUE> in <MAP> : <OUTPUT>]
  bucket = "${each.value}"
  acl    = "public-read"
}
/*
output "key_value_data" {
  value = {for k, v in aws_s3_bucket.s3demobucket : k => v.id}
}

output "all_details" {
  value = values(aws_s3_bucket.s3demobucket)[*].arn
}

output "key_value_info" {
  value = aws_s3_bucket.s3demobucket
}

output "key_filtered_data" {
  value = [for name in var.names : upper(name) if length(name) < 5]
}
*/