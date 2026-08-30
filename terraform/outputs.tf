output "ec2_public_ip" {
  description = "Public IP of the EC2 instance - visit http://<this-ip>:5000"
  value       = aws_instance.app_server.public_ip
}

output "app_url" {
  description = "Direct link to your running app"
  value       = "http://${aws_instance.app_server.public_ip}:5000"
}
