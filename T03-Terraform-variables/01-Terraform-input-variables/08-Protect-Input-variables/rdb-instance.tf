resource "aws_db_instance" "mydb-server" {
  allocated_storage = 5
  engine = "mysql"
  instance_class = "db.t2.micro"
  name = "mysql-demo"
  username = var.username
  password = var.password
  skip_final_snapshot = true
}