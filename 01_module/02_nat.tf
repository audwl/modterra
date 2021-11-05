resource "aws_eip" "lb_ip" {
#   instance = aws_instance.web.id     
  vpc = true
}
resource "aws_nat_gateway" "mjkim_nga" {
    allocation_id = aws_eip.lb_ip.id
    subnet_id = aws_subnet.mjkim_pub[0].id
    tags = {
      Name = "${var.name}-ng"
    } 
}
resource "aws_route_table" "mjkim_ngart" {
  vpc_id  =  aws_vpc.mjkim_vpc.id
  route {
    cidr_block  = var.cidr
    gateway_id  = aws_nat_gateway.mjkim_nga.id
  }
  tags  = {
    Name  = "${var.name}-ng-rt"
  }
}
resource "aws_route_table_association" "mjkim_ngartas" {
    count = "${length(var.avazone)}"
    subnet_id = aws_subnet.mjkim_pri[count.index].id
    route_table_id = aws_route_table.mjkim_ngart.id
}

