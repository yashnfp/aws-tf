# 1. Find the Default VPC that already exists in your account
data "aws_vpc" "default" {
  default = true
}

# 2. Find the latest Amazon Linux 2 AMI
data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# 3. Launch the EC2
resource "aws_instance" "my_server" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = var.instance_type
  
  # Terraform automatically picks a subnet in the default VPC if you don't specify one
  tags = {
    Name = "Step-1-EC2"
  }
}