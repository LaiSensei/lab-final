resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key_pair" {
  key_name   = "key"
  public_key = tls_private_key.key.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.key.private_key_pem}' > ${path.module}/key.pem && chmod 0700 ${path.module}/key.pem"
  }
}

resource "aws_launch_template" "app_server_launch" {
  name_prefix   = "connectus-app-server"
  image_id      = "ami-0d53d72369335a9d6"  # Use the correct AMI ID
  instance_type = "t2.micro"
  key_name      = aws_key_pair.key_pair.key_name

  network_interfaces {
    associate_public_ip_address = true
    subnet_id                  = aws_subnet.connectus_subnet.id
    security_groups            = [aws_security_group.connectus_sg.id]
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_autoscaling_group" "app_server_asg" {
  desired_capacity     = 2
  max_size             = 4
  min_size             = 1
  vpc_zone_identifier  = [aws_subnet.connectus_subnet.id, aws_subnet.connectus_subnet_2.id]
  launch_template {
    id      = aws_launch_template.app_server_launch.id
    version = "$Latest"
  }
  health_check_type           = "EC2"
  health_check_grace_period   = 300
  wait_for_capacity_timeout    = "0"

  tag {
    key                 = "Name"
    value               = "ConnectUsAppServer"
    propagate_at_launch = true
  }
}


output "load_balancer_dns" {
  value = aws_lb.connectus_lb.dns_name
}


