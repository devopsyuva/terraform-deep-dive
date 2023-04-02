resource "aws_eip" "static-ip" {
  instance   = aws_instance.web.id
  vpc        = true
  depends_on = [aws_internet_gateway.igw]
}
