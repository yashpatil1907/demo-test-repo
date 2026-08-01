resource "aws_instance" "jenkins" {

  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  subnet_id = "subnet-0222f7369b1d4c555"

  vpc_security_group_ids = [
    "sg-0309363fa4003721d"
  ]

  key_name = var.key_name

  associate_public_ip_address = true

  user_data = file("userdata.sh")

  tags = {
    Name = "Jenkins-Server"
  }

}