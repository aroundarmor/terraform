resource "aws_instance" "dummy1" {
  ami = "ami-0277155c3f0ab2930"
  instance_type = var.instance_type
  #vpc_security_group_ids = ["security-group"]
  
}
