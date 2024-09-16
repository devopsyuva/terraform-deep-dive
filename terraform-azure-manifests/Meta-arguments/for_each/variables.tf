variable "users_data" {
  description = "Provide user profile information"
  type = map(object({
    principal_name = string
    name           = string
    nick_name      = string
    passwrd        = string
  }))
  default = {
    "Visualpath01" = {
      "principal_name" = "visualpath01@sudhamsdevopsgmail.onmicrosoft.com"
      "name"           = "Visualpath Pvt Ltd 01"
      "nick_name"      = "Visual01"
      "passwrd"        = "SecretP@sswd999"
    },
    "Visualpath02" = {
      "principal_name" = "visualpath02@sudhamsdevopsgmail.onmicrosoft.com"
      "name"           = "Visualpath Pvt Ltd 02"
      "nick_name"      = "Visual02"
      "passwrd"        = "SecretP@sswd999"
    },
    "Visualpath04" = {
      "principal_name" = "visualpath04@sudhamsdevopsgmail.onmicrosoft.com"
      "name"           = "Visualpath Pvt Ltd 04"
      "nick_name"      = "Visual04"
      "passwrd"        = "SecretP@sswd999"
    }
  }
}