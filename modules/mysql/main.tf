resource "aws_security_group" "rds_sg" {
  name        = "${var.environment}-rds-sg"
  description = "Allow traffic for MySql database"
  vpc_id      = var.vpc_id

  ingress {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-rds-sg"
  }
}

resource "aws_db_subnet_group" "mysql_db_subnet_group" {
  name          = "${var.environment}-mysql-db-subnet-group"
  subnet_ids    = var.subnet_ids

  tags = {
    Name = "${var.environment}-mysql-db-subnet-group"
  } 
}

resource "aws_db_instance" "mysql_db" {
  allocated_storage = var.allocated_storage
  storage_type      = var.storage_type
  engine            = "mysql"
  engine_version    = var.mysql_version
  instance_class    = var.mysql_instance_class
  identifier        = var.mysql_db_identifier
  username          = var.mysql_username
  password          = var.mysql_password
  db_name           = var.mysql_db_name

  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name = aws_db_subnet_group.mysql_db_subnet_group.name

  skip_final_snapshot = true
}