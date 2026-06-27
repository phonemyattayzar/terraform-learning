# Inpute Variable
variable "aws_region" {
    description = "Region in which aws resources to be created"
    type = string
    default = "ap-southeast-1"
}

variable "instance_type" {
  description = "EC2 Instnace Type"
  type = string
  default = "t3.micro"
}

variable "instance_keypair" {
    description = "AWS EC2 Key Pair that need to be associated with EC2 Instance"
    type = string
    default = "terraform-key"
}