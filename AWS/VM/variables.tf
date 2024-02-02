variable "region" {
  description = "defines value of region"
  default = "us-east-1"
  type = string
}

variable "instance_type" {
  description = "defines instance type"
  default = "t2.micro"
  type = string
}