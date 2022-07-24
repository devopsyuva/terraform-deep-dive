resource "aws_ebs_volume" "ec2-volume" {
    availability_zone = var.az_name
    size = 30
    type = "gp2" #deafult
    
    tags = {
        Name = "sudheer-demo"
    }
}

resource "aws_volume_attachment" "name" {
    device_name = "/dev/sdd"
    volume_id = aws_ebs_volume.ec2-volume.id
    instance_id = aws_instance.web.id
}