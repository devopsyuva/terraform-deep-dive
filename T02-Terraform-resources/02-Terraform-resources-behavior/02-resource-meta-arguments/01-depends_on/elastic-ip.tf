resource "aws_eip" "demo-eip" {
    instance = aws_instance.web.id
    vpc = true
    depends_on = [aws_internet_gateway.igw]
}