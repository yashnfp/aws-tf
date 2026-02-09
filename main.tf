# ---------------------------------------------------------------------------------------------------------------------
# TERRAFORM SETTINGS & PROVIDER
# ---------------------------------------------------------------------------------------------------------------------
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1" # <--- Ensure this matches your pipeline region
}

# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES
# ---------------------------------------------------------------------------------------------------------------------
variable "instance_type" {
  description = "The EC2 instance type"
  type        = string
  default     = "t2.micro" # <--- Force t2.micro for Free Tier
}

# ---------------------------------------------------------------------------------------------------------------------
# DATA SOURCES
# ---------------------------------------------------------------------------------------------------------------------

# 1. Find the Default VPC that already exists in your account
data "aws_vpc" "default" {
  default = true
}

# 2. Find the latest Amazon Linux 2 AMI (x86_64 for t2.micro)
data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# RESOURCES
# ---------------------------------------------------------------------------------------------------------------------

# 3. Launch the EC2
resource "aws_instance" "my_server" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = var.instance_type
  
  # Optional: Security Group to allow SSH (Best practice)
  # vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "Step-1-EC2"
  }
}