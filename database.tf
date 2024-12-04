resource "aws_db_instance" "connectus_postgresql" {
  identifier         = "connectus-postgresql-db"
  engine             = "postgres"
  engine_version     = "13"
  instance_class     = "db.t3.micro"
  allocated_storage  = 20
  username           = "connectUs_master"
  password           = "NotUberSecretPassword"
  db_name            = "connectusdb"
  multi_az           = false
  publicly_accessible = true
  vpc_security_group_ids = [aws_security_group.connectus_sg.id]
  db_subnet_group_name = aws_db_subnet_group.connectus_db_subnet_group.name
}



resource "aws_dynamodb_table" "connectus_dynamodb" {
  name           = "connectus-table"
  hash_key       = "connectUs_master"
  read_capacity  = 5
  write_capacity = 5

  attribute {
    name = "connectUs_master"
    type = "S"
  }

  billing_mode = "PROVISIONED"
}
