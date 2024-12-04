resource "aws_security_group" "connectus_sg" {
  name        = "connectus-sg"
  description = "Security group for ConnectUs application"
  vpc_id      = aws_vpc.connectus_vpc.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # Allow access from within the VPC
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}