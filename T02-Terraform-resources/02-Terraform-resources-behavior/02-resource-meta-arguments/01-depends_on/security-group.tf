resource "aws_security_group" "test-security-group" {
    name = "test-demo-sg"
    description = "VPC sg for demo"
    vpc_id = aws_vpc.test-vpc.id

    ingress = [ {
      cidr_blocks = [ "0.0.0.0/0" ]
      description = "Allow ssh connection"
      from_port = 22
      protocol = "tcp"
      to_port = 22
    }, {
      cidr_blocks = [ "0.0.0.0/0" ]
      description = "Allow web access"
      from_port = 80
      protocol = "tcp"
      to_port = 80
    } ]

    egress = {
        description = "All out going traffic is enabled"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}