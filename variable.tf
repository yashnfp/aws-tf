variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro" # Stay in Free Tier
}

variable "project_name" {
  description = "Name for tagging resources"
  type        = string
  default     = "st-cloud-project"
}