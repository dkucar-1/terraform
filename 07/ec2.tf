# pick something Ubuntu like 
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

output "ubuntu_ami_id" {
  value = data.aws_ami.ubuntu.id
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_vpc" "prod-vpc" {
  default = true
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_s3_bucket" "public-read-bucket" {
  bucket = "sample"
}

data "aws_iam_policy_document" "public_access_bucket" {
  statement {
    sid = "PublicReadGetObject"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = ["s3:GetObject"]

    resources = ["arn:aws:s3:::*/*"]
  }
}

output iam_policy {
  value = data.aws_iam_policy_document.public_access_bucket.json
}

resource "aws_instance" "nginx_instance" {
  ami                         = "ami-0f62bd5258b0cb717" # NGINX on Amazon Linux 2"
  associate_public_ip_address = true
  instance_type               = "t2.micro"


}
