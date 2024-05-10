#Security group for the load balancer that allows connections on ports 3000 (backend code) 22 ssh configuration.
resource "aws_security_group" "sg_elb" {
  name          = "${var.environment}-sg-elb"
  description   = "Route table for ELB" 
  vpc_id        = var.vpc_id

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Load balancer with listener on port 3000 (Same as backend instances) and health check on port 22 for the instances. Created on private subnets
resource "aws_elb" "backend_elb" {
  name                      = "${var.environment}-backend-elb"
  security_groups           = [aws_security_group.sg_elb.id]
  subnets                   = var.elb_subnets
  cross_zone_load_balancing = true
  internal                  = true

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "TCP:22"
  }

  listener {
    lb_port             = 3000
    lb_protocol         = "http"
    instance_port       = "3000"
    instance_protocol   = "http"
  }
}

#Launch configuration for the backend instances
resource "aws_launch_configuration" "backend_instances" {
  name_prefix                   = "${var.environment}-backend-"
  image_id                      = var.ami
  instance_type                 = var.instance_type
  key_name                      = var.key_name
  security_groups               = [aws_security_group.sg_elb.id]
  associate_public_ip_address   = false

  lifecycle {
    create_before_destroy = true
  }

}

#Autoscaling group for the backend instances with min size 1 and maz size 2
resource "aws_autoscaling_group" "asg_backend" {
  name                  = "${var.environment}-asg-backend"
  launch_configuration  = aws_launch_configuration.backend_instances.name
  min_size              = 1
  max_size              = 2
  health_check_type     = "ELB"
  load_balancers        = [aws_elb.backend_elb.id]
  vpc_zone_identifier   = var.elb_subnets

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "${var.environment}-backend-end-instance"
    propagate_at_launch = true
  }

  #The backend instances shall be created with tag Type=backend so it can be configured via Ansible dynamic inventories.
  tag {
    key                 = "Type"
    value               = "backend"
    propagate_at_launch = true
  }
}