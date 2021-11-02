provider "aws" {
  region = var.region
}

resource "aws_key_pair" "mjkim_key" {
  key_name = "var.key1"
  public_key = file("../../../.ssh/id_rsa.pub")
}
resource "aws_vpc" "mjkim_vpc" {
  cidr_block = var.cidr_main
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
      Name   =  "${var.name}-vpc"  
  }
}

resource "aws_subnet" "mjkim_pub" {
    vpc_id =aws_vpc.mjkim_vpc.id  
    count = "${length(var.public_s)}" #2
    cidr_block = "${var.public_s[count.index]}"
    availability_zone = "${var.region}${var.avazone[count.index]}"
    tags = {
      Name = "pub-${var.avazone[count.index]}"
    }
  
}

resource "aws_subnet" "mjkim_pri" {
    vpc_id = aws_vpc.mjkim_vpc.id
    count = "${length(var.private_s)}"
    cidr_block = "${var.private_s[count.index]}"
    availability_zone = "${var.region}${var.avazone[count.index]}"
    tags = {
      Name = "pri-${var.avazone[count.index]}"
    }
  
}
resource "aws_subnet" "mjkim_pridb" {
    vpc_id = aws_vpc.mjkim_vpc.id
    count = "${length(var.private_dbs)}"
    cidr_block = "${var.private_dbs[count.index]}"
    availability_zone = "${var.region}${var.avazone[count.index]}"
    tags = {
      Name = "pridb-${var.avazone[count.index]}"
    }
  
}
resource "aws_internet_gateway" "mjkim_ig" {
  vpc_id = aws_vpc.mjkim_vpc.id
  tags = {
    Name = "${var.name}-ig"
  }
}
resource "aws_route_table" "mjkim_rt" {
  vpc_id = aws_vpc.mjkim_vpc.id

  route {
  #  carrier_gateway_id = "value"
    cidr_block = var.cidr
  #  destination_prefix_list_id = "value"
  #  egress_only_gateway_id = "value"
    gateway_id = aws_internet_gateway.mjkim_ig.id
  #  instance_id = "value"
  #  ipv6_cidr_block = "value"
  #  local_gateway_id = "value"
  #  nat_gateway_id = "value"
  #  network_interface_id = "value"
  #  transit_gateway_id = "value"
  #  vpc_endpoint_id = "value"
  #  vpc_peering_connection_id = "value"
  } 
  tags = {
    Name = "${var.name}-rt"
  }
}
resource "aws_route_table_association" "mjkim_rtas_a" {
    count = "${length(var.public_s)}"
    subnet_id = aws_subnet.mjkim_pub[count.index].id
    route_table_id = aws_route_table.mjkim_rt.id
}
