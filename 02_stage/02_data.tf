module "stage" {
    source  =  "../01_module"

    region  = "ap-northeast-1"
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
    prot_http = "http"
    prot_icmp = "icmp"
    prot_tcp = "tcp"
    prot_ssh = "ssh"
    prot_mysql = "mysql"
    instance = "t2.micro"
}