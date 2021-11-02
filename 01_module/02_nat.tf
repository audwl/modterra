resource "aws_eip" "lb_ip" {
#   instance = aws_instance.web.id     
  vpc = true
  tags = {
     "Name" = "${var.name}-IP"
  }
}
resource "aws_nat_gateway" "mjkim_nga" {
    allocation_id = aws_eip.lb_ip.id
    subnet_id = aws_subnet.mjkim_pub[0].id
    tags = {
      Name = "${var.name}-nga-[0]"
    } 
}
resource "aws_route_table" "mjkim_ngart" {
  vpc_id  =  aws_vpc.mjkim_vpc.id
  route {
    cidr_block  = var.cidr
    gateway_id  = aws_nat_gateway.mjkim_nga.id
  }
  tags  = {
    Name  = "${var.name}-nga-rta"
  }
}
resource "aws_route_table_association" "mjkim_ngartas" {
    count = 2
    subnet_id = aws_subnet.mjkim_pri[count.index].id
    route_table_id = aws_route_table.mjkim_ngart.id
}

