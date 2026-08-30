variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "instance_type" {
  description = "EC2 instance size"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of an existing EC2 Key Pair (create this in AWS Console first, under EC2 > Key Pairs)"
  type        = string
}

variable "my_ip" {
  description = "Your own IP address in CIDR form, e.g. 49.207.10.20/32 (used to lock down SSH). Get it from whatismyip.com"
  type        = string
}

variable "docker_image" {
  description = "Docker Hub image to pull and run on EC2, e.g. yourusername/devops-minor-project:latest"
  type        = string
}
