resource "aws_security_group" "public_http" {
  name        = "public_http"
  description = "Allow HTTP and HTTPS"
  vpc_id      = aws_vpc.main_vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.public_http.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.public_http.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

resource "aws_instance" "nginx_instance" {
  ami                         = "ami-0f62bd5258b0cb717 # NGINX on Amazon Linux 2"
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.public_http.id]

  # create new instance first, then destroy old one to avoid downtime
  lifecycle {
    create_before_destroy = true
  }
}