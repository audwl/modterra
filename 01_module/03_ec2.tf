resource "aws_security_group" "mjkim_websg" {
    name = "Allow-WEB"
    description = "http-ssh-icmp"
    vpc_id = aws_vpc.mjkim_vpc.id
    ingress = [
        {
        description = var.prot_ssh
        from_port = var.ssh_port
        to_port = var.ssh_port
        protocol = var.prot_tcp
        cidr_blocks = [var.cidr]
        ipv6_cidr_blocks = [var.cidr_v6]
        security_groups = null
        prefix_list_ids = null
        self = null
},

 {
        description = var.prot_http
        from_port = var.http_port
        to_port = var.http_port
        protocol = var.prot_tcp
        cidr_blocks = [var.cidr]
        ipv6_cidr_blocks = [var.cidr_v6]
        security_groups = null
        prefix_list_ids = null
        self = null
},

 {
        description = var.prot_icmp
        from_port = var.under_port
        to_port = var.under_port
        protocol = var.prot_icmp
        cidr_blocks = [var.cidr]
        ipv6_cidr_blocks = [var.cidr_v6]
        security_groups = null
        prefix_list_ids = null
        self = null
},
{
        description = var.prot_mysql
        from_port = var.mysql_port
        to_port = var.mysql_port
        protocol = var.prot_tcp
        cidr_blocks = [var.cidr]
        ipv6_cidr_blocks = [var.cidr_v6]
        security_groups = null
        prefix_list_ids = null
        self = null
}
]

egress = [
    {
        description = "All"
        from_port = var.zero_port
        to_port = var.zero_port
        protocol = -1
        cidr_blocks = [var.cidr]
        ipv6_cidr_blocks = [var.cidr_v6]
        security_groups = null
        prefix_list_ids = null
        self = null
    }]
tags = {
  Name = "${var.name}-sg"
}
  
}

data "aws_ami" "amzn" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "mjkim_web" {
  ami                    = "ami-0e4a9ad2eb120e054"                             #data.aws_ami.amzn.id
  instance_type          = var.instance
  key_name               = var.key
  vpc_security_group_ids = [aws_security_group.mjkim_websg.id]
  availability_zone      = "${var.region}${var.avazone[0]}"
  private_ip             = var.private_ip
  subnet_id              = aws_subnet.mjkim_pub[0].id
  user_data              = file("./install_seoul.sh") 

  tags = {
    Name = "${var.name}-weba"
  }
}
resource "aws_eip" "mjkim_web_eip" {
  vpc = true
  instance                    = aws_instance.mjkim_web.id
  associate_with_private_ip   = var.private_ip
  depends_on                  = [aws_internet_gateway.mjkim_ig]
}
