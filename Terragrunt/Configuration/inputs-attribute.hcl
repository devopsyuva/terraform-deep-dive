prevent_destroy = true
inputs = {
  string      = "us-east-1"
  number      = 42
  bool        = true
  list_string = ["us-east-1a", "us-east-1b", "us-east-1c"]
  list_number = [1, 2, 3]
  list_bool   = [true, false]

  map_string = {
    foo = "bar"
  }

  map_number = {
    count = 2
    age   = 24
  }

  map_bool = {
    foo = true
    bar = false
  }

  object = {
    str  = "us-east-1"
    num  = 42
    list = [1, 2, 3]

    map = {
      foo = "bar"
    }
  }

  from_env = get_env("FROM_ENV", "default")
}