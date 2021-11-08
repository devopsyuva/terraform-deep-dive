/*
This configuration will create 3 s3 buckets which names
provided with key-value on AWS provider
*/
resource "aws_s3_bucket" "s3demobucket" {
  for_each = {
    dev = "s3-dev-bucket"
    test = "s3-test-bucket"
    qa = "s3-qa-bucket"
  }
  bucket = "${each.key}-${each.value}"
  acl = "private"

  tags = {
    Name = "${each.key}-${each.value}"
    Eachvalue = each.value
    Eachkey = each.key
  }
}