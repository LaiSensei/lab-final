resource "aws_vpc" "connectus_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "connectus-vpc"
  }
}

resource "aws_internet_gateway" "connectus_igw" {
  vpc_id = aws_vpc.connectus_vpc.id
  tags = {
    Name = "connectus-igw"
  }
}


resource "aws_subnet" "connectus_subnet" {
  vpc_id     = aws_vpc.connectus_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "connectus-subnet"
  }
}

resource "aws_subnet" "connectus_subnet_2" {
  vpc_id                  = aws_vpc.connectus_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-west-1c"  # Use a different AZ
  map_public_ip_on_launch = true
  tags = {
    Name = "connectus-subnet-2"
  }
}

resource "aws_db_subnet_group" "connectus_db_subnet_group" {
  name        = "connectus-db-subnet-group"
  description = "Subnet group for ConnectUs database"
  subnet_ids  = [
    aws_subnet.connectus_subnet.id,
    aws_subnet.connectus_subnet_2.id
  ]
}


