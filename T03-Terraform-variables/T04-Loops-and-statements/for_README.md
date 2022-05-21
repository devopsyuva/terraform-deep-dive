## for loop example:
- for loop can be used over lists and maps
- Syntax for lists: output as list --> [for \<ITEM\> in \<LIST\> : \<OUTPUT\>], output as map --> {for \<ITEM\> in \<LIST\> : \<OUTPUT_KEY\> => \<OUTPUT_VALUE\>}
- Syntax for maps: output as list --> [for \<KEY\>, \<VALUE\> in \<MAP\> : \<OUTPUT\> ], output as map --> {for \<KEY\>, \<VALUE\> in \<MAP\> : \<OUTPUT_KEY\> => \<OUTPUT_VALUE\>}
- Example for lists:
```
variable "names" {
  description = "A list of names"
  type        = list(string)
  default     = ["sudheer", "visualpath", "sandeep", "praveen kumar"]
}
output "short_upper_names" {
  value = [for name in var.names : upper(name) if length(name) < 8]
}
```
- Example for maps:
```
Scenario: 1 (it will print output in form of list)
variable "user_data" {
  description = "map"
  type        = map(string)
  default     = {
    user      = "visualpath"
    domain    = "visualpath pvt ltd"
    course    = "DevOps"
  }
}
output "user_full_details" {
  value = [for name, role in var.user_data : "${name} name is ${role}"]
}

Scenario: 2 (It will print output as map istead of list)
variable "user_data" {
  description = "map"
  type        = map(string)
  default     = {
    user      = "visualpath"
    domain    = "visualpath pvt ltd"
    course    = "DevOps"
  }
}
output "user_full_details" {
  value = {for name, role in var.user_data : name => role}
}
```

### Reference:
- [for condition](https://www.terraform.io/language/expressions/for)