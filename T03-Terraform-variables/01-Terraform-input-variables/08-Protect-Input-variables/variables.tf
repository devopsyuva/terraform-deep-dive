variable "username" {
  type        = string
  description = "The id of the machine image to use for the server."
}
variable "password" {
  type        = string
  description = "The id of the machine image to use for the server."
  sensitive = true
}