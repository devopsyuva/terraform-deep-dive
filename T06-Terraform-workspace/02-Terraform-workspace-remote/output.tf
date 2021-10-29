output "ec2_instance_private_ip" {
  value       = aws_instance.web.*.private_ip
  description = "EC2 instance Private IP address"
}

output "ec2_instance_public_ip" {
  value       = aws_instance.web.*.public_ip
  description = "EC2 instance Public IP address"
}

output "ec2_instance_public_dns" {
  value       = "http://aws_instance.web.*.public_dns"
  description = "EC2 instance Private DNS name"
  sensitive   = true
}