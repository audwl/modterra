variable "name" {
  type = string
  default = "mjkim"
}

variable "instance" {
  type = string
  default = "t2.micro"
}

variable "avazone" {
    type = list
    default = ["a","c"]
  
}
variable "region" {
    type = string
    default = "ap-northeast-2"
}

variable "key" {
  type = string
  default = "tf-key1"
}

variable "cidr" {
  type = string
  default = "0.0.0.0/0"
}

variable "cidr_v6" {
  type = string
  default = "::/0"
}
variable "cidr_main" {
  type = string
 default = "10.0.0.0/16"
}

variable "public_s" {
  type = list
  default = ["10.0.0.0/24", "10.0.2.0/24"]
}

variable "private_s" {
  type = list
  default = ["10.0.1.0/24", "10.0.3.0/24"]
}

variable "private_dbs" {
  type = list
  default = ["10.0.4.0/24", "10.0.5.0/24"]
}

variable "private_ip" {
  type  = string
  default = "10.0.0.11"
}
variable "zero_port" {
  type = number
  default = 0
}
variable "under_port" {
  type = number
  default = -1
}

variable "ssh_port" {
  type = number
  default = 22
}

variable "http_port" {
  type = number
  default = 80
}

variable "mysql_port" {
  type = number
  default = 3306
}
variable "prot_tcp" {
  type = string
  default = "TCP"
}
variable "prot_udp" {
  type = string
  default = "UDP"

variable "prot_http" {
  type = string
  default = "HTTP"
}

variable "prot_icmp" {
  type = string
  default = "ICMP"
}

variable "prot_ssh" {
  type = string
  default = "SSH"
}

variable "prot_mysql" {
  type = string
  default = "MYSQL"
}

variable "name_db" {
  type=string
  default = "mydb"
}

variable "ami" {
  type = string
  default = "ami-0e4a9ad2eb120e054" 
  
}
  variable "load_type" {
  type  = string
#  default = "application"
}

variable "strategy" {
  type  = string
#  default = "cluster"
}

variable "storage_size" {
  type = number
#  default = 20
}

variable "storage_type" {
  type = string
#  default = gp2
}

variable "mysql_version" {
  type = string
#  default = "8.0"
}

variable "username" {
  type = string
#  default = "admin"
}

variable "password" {
  type = string
#  default = "It12345!"
}


variable "instance_db" {
  type  = string
#  default = "db.t2.micro"
}

variable "endpoint" {
  type  = string
  default = "data.aws_db_instance.mydb.endpoint"
}
