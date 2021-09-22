resource "aws_s3_bucket" "s3demobucket" {
  for_each = var.bucket_names
  bucket   = "${each.key}-${each.value}"
  acl      = "private"

  tags = {
    Name = "${each.key}-${each.key}"
  }
}