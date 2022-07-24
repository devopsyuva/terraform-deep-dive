variable "bucket_name" {
    description = "Bucket Name which should be unique across Region"
    type = string
    default = "sudheer-demo-static"
}

locals {
  common_tags = {
      Name = "Web-App"
      Env  = "Production"
  }
}