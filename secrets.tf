#resource "aws_secretsmanager_secret" "connectus_db_credentials" {
#  name = "connectus-db-credentials"
#}

#resource "aws_secretsmanager_secret_version" "connectus_db_credentials_version" {
#  secret_id     = aws_secretsmanager_secret.connectus_db_credentials.id
#  secret_string = jsonencode({
#    username = "connectUs_master"
#    password = "NotUberSecretPassword"
#  })
#}
