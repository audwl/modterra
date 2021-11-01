#!/bin/bash
yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum install -y yum-utils wget httpd
amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
wget https://ko.wordpress.org/latest-ko_KR.tar.gz
tar xvfz latest-ko_KR.tar.gz
cp -a wordpress/* /var/www/html/
chown apache.apache /var/www/html/*
sed -i 's/DirectoryIndex index.html/DirectoryIndex index.php/g' /etc/httpd/conf/httpd.conf
cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
sed -i 's/database_name_here/mydb/g' /var/www/html/wp-config.php
sed -i 's/username_here/admin/g' /var/www/html/wp-config.php
sed -i 's/password_here/It12345!/g' /var/www/html/wp-config.php
sed -i 's/localhost/mydb.cxmtjrbucdp3.ap-northeast-2.rds.amazonaws.com/g' /var/www/html/wp-config.php
cat > /var/www/html/health.html << EOF
<html><body><h1>MJKIM WEB SERVER _ health </h1></body></html>
EOF
systemctl enable httpd
systemctl start httpd