variable "project_name" { type = string }
variable "environment" { type = string }
variable "vpc_id" { type = string }
variable "private_subnet_id" { type = string }
variable "instance_type" { type = string }
variable "ami_id" { type = string }
variable "eks_sg_id" { type = string }
variable "rabbitmq_password" {
  type      = string
  default   = "changeme123!"
  sensitive = true
}
