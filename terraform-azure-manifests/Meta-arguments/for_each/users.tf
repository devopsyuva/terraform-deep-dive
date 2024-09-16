resource "azuread_user" "example" {
  for_each            = var.users_data
  user_principal_name = each.value["principal_name"]
  display_name        = each.value["name"]
  mail_nickname       = each.value["nick_name"]
  password            = each.value["passwrd"]

  lifecycle {
    #create_before_destroy = true
    #ignore_changes = [ password, display_name ]
    #prevent_destroy = true
  }
}