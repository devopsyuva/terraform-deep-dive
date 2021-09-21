output "ec2_instance_private_ip" {
    value = module.ec2_cluster.*.private_ip
    description = "EC2 instance Private IP address"
}

output "ec2_instance_public_ip" {
    value = module.ec2_cluster.*.public_ip
    description = "EC2 instance Public IP address"
}

output "ec2_instance_public_dns" {
    value = "http://module.ec2_cluster.*.public_dns"
    description = "EC2 instance Private DNS name"
}