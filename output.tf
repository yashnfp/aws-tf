output "instance_public_ip" {
  value       = aws_instance.app_server.public_ip
  description = "The public IP of the EC2 instance"
}

# Fix: Changed 'latest_amazon_linux' to 'amazon_linux' to match main.tf
output "ami_id_used" {
  value = data.aws_ami.amazon_linux.id
}