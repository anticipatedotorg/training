#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-ecc63a94
#
# Your subnet ID is:
#
#     subnet-e700adaf
#
# Your security group ID is:
#
#     sg-55f65f28
#
# Your Identity is:
#
#     test-training-jb-peafowl
#
variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "aws_region" {
  default = "us-west-2"
}

variable "totalcount" {
  default = "3"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  ami                    = "ami-ecc63a94"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-e700adaf"
  vpc_security_group_ids = ["sg-55f65f28"]
  count                  = "${var.totalcount}"

  tags = {
    Identity = "test-training-jb-peafowl"
    Owner    = "Amy Brown"
    Desc     = "Test box"
    Name     = "web ${count.index+1}/${var.totalcount}"
  }
}

output "public_ip" {
  value = "${aws_instance.web.*.public_ip}"
}

output "public_dns" {
  value = "${aws_instance.web.*.public_dns}"
}

terraform {
  backend "atlas" {
    name = "anticipate/training"
  }
}
