resource "aws_db_instance" "mjkim_mydb" {
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = var.prot_mysql
  engine_version          = "8.0"
  instance_class          = "db.t2.micro"
  name                    = "mydb"
  identifier              = "mydb"
  username                = "admin"
  password                = "It12345!"
  parameter_group_name    = "default.mysql8.0"
  availability_zone       = var.region
  db_subnet_group_name    = aws_db_subnet_group.mjkim_dbsn.id
  vpc_security_group_ids  = [aws_security_group.mjkim_websg.id]
  skip_final_snapshot     = true
  tags = {
      Name = "${var.name}-mydb"
  }
}

resource "aws_db_subnet_group" "mjkim_dbsn" {
  name  =   "mjkim-dbsb-group"
  count = 2
  subnet_ids = [aws_subnet.mjkim_pridb[count.index].id]
  tags = {
      Name = "mjkim-dbsb-group"
  }
}