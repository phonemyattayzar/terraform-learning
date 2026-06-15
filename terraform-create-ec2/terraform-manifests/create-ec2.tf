# Resource: EC2 Instance
resource "aws_instance" "ubuntu-vm" {
  ami = "ami-0532913178263be11"
  instance_type = "t3.micro"
  user_data = file("${path.module}/user-data.sh")
  tags = {
    "Name" = "EC2 Demo"
  }
}