resource "aws_iam_role" "ecs_execution_role" {
  name = "ecs-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role" "ecs_task_role" {
  name = "ecs-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}



resource "aws_ecs_cluster" "connectus_ecs_cluster" {
  name = "connectus-cluster"
}

resource "aws_ecs_task_definition" "connectus_task_definition" {
  family                   = "connectus-task"
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  network_mode            = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = "256"  # Define CPU units
  memory = "512"  # Define memory in MiB

  container_definitions = <<DEFINITION
  [
    {
      "name": "connectus-container",
      "image": "your-docker-image",
      "memory": 512,
      "cpu": 256,
      "essential": true,
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 80
        }
      ]
    }
  ]
  DEFINITION
}


resource "aws_ecs_service" "connectus_service" {
  name            = "connectus-service"
  cluster         = aws_ecs_cluster.connectus_ecs_cluster.id
  task_definition = aws_ecs_task_definition.connectus_task_definition.arn
  desired_count   = 2
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = [aws_subnet.connectus_subnet.id, aws_subnet.connectus_subnet_2.id]
    security_groups = [aws_security_group.connectus_sg.id]
  }
}
