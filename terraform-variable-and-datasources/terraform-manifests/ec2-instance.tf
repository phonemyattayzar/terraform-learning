resource "aws_instance" "ubuntuvm" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  user_data = file("${path.module}/user-data.sh")
  key_name = var.instance_keypair
  vpc_security_group_ids = [
    aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id
  ]
  tags = {
    "Name" = "EC2 Demo"
  }
}