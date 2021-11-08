/*
This configuration will create 3 s3 buckets which names
provided with key-value on AWS provider
*/
resource "aws_s3_bucket" "s3demobucket" {
  for_each = {
    dev  = "s3-dev-bucket"
    test = "s3-test-bucket"
    qa   = "s3-qa-bucket"
  }
  bucket = "${each.key}-${each.value}"
  acl    = "public-read"
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
    Eachvalue = each.value
    Eachkey   = each.key
  }
}