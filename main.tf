resource "aws_instance" "this" {
  ami                         = "ami-013a28d7c2ea10269"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public["public_subnet_1a"].id
  security_groups             = [aws_security_group.this.id]
  iam_instance_profile        = aws_iam_instance_profile.ssm_instance_profile.name
  associate_public_ip_address = true
  tags = {
    Name = "${var.prefix}-ec2"
  }
  # 起動時に実行されるスクリプト
  user_data = <<-EOF
#!/bin/bash

# パッケージリストの更新

yum update -y

# ApacheとMariaDB、PHPのインストール
dnf install wget php-mysqlnd httpd php-fpm php-mysqli mariadb105-server php-json php php-devel -y

# Apacheの起動と自動起動の設定
systemctl start httpd
systemctl enable httpd

# MariaDBの起動と自動起動の設定
systemctl start mariadb
systemctl enable mariadb

# MySQL設定とWordPress用データベースの作成
mysql -e "CREATE DATABASE ${var.db_name};"
mysql -e "CREATE USER '${var.db_user}'@'localhost' IDENTIFIED BY '${var.db_password}';"
mysql -e "GRANT ALL PRIVILEGES ON ${var.db_name}.* TO '${var.db_user}'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"

# MariaDBのrootパスワードを設定
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${var.db_root_password}';"

# WordPressのダウンロードと展開
cd /var/www/html
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
mv wordpress/* .
rm -rf wordpress latest.tar.gz

# WordPressの設定ファイル編集
cp wp-config-sample.php wp-config.php
sed -i "s/database_name_here/${var.db_name}/" wp-config.php
sed -i "s/username_here/${var.db_user}/" wp-config.php
sed -i "s/password_here/${var.db_password}/" wp-config.php

# ディレクトリ権限の設定
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html

# Apacheの再起動
systemctl restart httpd
EOF
}