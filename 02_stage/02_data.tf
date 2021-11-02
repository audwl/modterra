module "stage" {
    source  =  "../01_module"

    name = "mykim"
    region  = "ap-northeast-3"
    ami = "ami-026107638e7d599b1"
    cidr    = "0.0.0.0/0"
    cidr_main = "192.168.0.0/16"
    name = "mjkim"
    avazone = ["a", "c"]
    key = "tf-key1"
    public_s = ["192.168.0.0/24", "192.168.2.0/24"]
    private_s = ["192.168.1.0/24", "192.168.3.0/24"]
    private_dbs = ["192.168.4.0/24", "192.168.5.0/24"]
    private_ip = "192.168.0.11"
    zero_port = 0
    under_port = -1
    ssh_port = 22
    http_port = 80
    mysql_port = 3306
    prot_http = "HTTP"
    prot_icmp = "ICMP"
    prot_tcp = "TCP"
    prot_ssh = "SSH"
    prot_mysql = "MYSQL"
    instance = "t3.micro"
    load_type            =  "application"
    strategy             =  "cluster"
    storage_size         =  20
    storage_type         =  "gp2"
    mysql_version        =  "8.0"
    sql_engine           =  "mysql"
    username             =  "admin"
    password             =  "It12345!"
    name_db              =  "mydb"
    instance_db          =  "db.t2.micro"
}
