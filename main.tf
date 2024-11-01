#プライベート
resource "aws_instance" "this" {
  ami                         = "ami-03f584e50b2d32776"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.private["private_subnet_1a"].id
  security_groups             = [aws_security_group.ec2.id]
  iam_instance_profile        = aws_iam_instance_profile.ssm_instance_profile.name
  associate_public_ip_address = false
  tags = {
    Name = "${var.prefix}-ec2"
  }
}



#パブリック
# resource "aws_instance" "this" {
#   ami                         = "ami-03f584e50b2d32776"
#   instance_type               = "t2.micro"
#   subnet_id                   = aws_subnet.public["public_subnet_1a"].id
#   security_groups             = [aws_security_group.ec2.id]
#   iam_instance_profile        = aws_iam_instance_profile.ssm_instance_profile.name
#   associate_public_ip_address = true
#   tags = {
#     Name = "${var.prefix}-ec2"
#   }
  # 起動時に実行されるスクリプト
  #   user_data = <<-EOF
  # #!/bin/bash

  # # パッケージリストの更新

  # yum update -y

  # # ApacheとMariaDB、PHPのインストール
  # dnf install wget php-mysqlnd httpd php-fpm php-mysqli mariadb105-server php-json php php-devel -y

  # # Apacheの起動と自動起動の設定
  # systemctl start httpd
  # systemctl enable httpd

  # # MariaDBの起動と自動起動の設定
  # systemctl start mariadb
  # systemctl enable mariadb

  # # MySQL設定とWordPress用データベースの作成
  # mysql -e "CREATE DATABASE ${var.db_name};"
  # mysql -e "CREATE USER '${var.db_user}'@'localhost' IDENTIFIED BY '${var.db_password}';"
  # mysql -e "GRANT ALL PRIVILEGES ON ${var.db_name}.* TO '${var.db_user}'@'localhost';"
  # mysql -e "FLUSH PRIVILEGES;"

  # # MariaDBのrootパスワードを設定
  # mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${var.db_root_password}';"

  # # WordPressのダウンロードと展開
  # cd /var/www/html
  # wget https://wordpress.org/latest.tar.gz
  # tar -xzf latest.tar.gz
  # mv wordpress/* .
  # rm -rf wordpress latest.tar.gz

  # # WordPressの設定ファイル編集
  # cp wp-config-sample.php wp-config.php
  # sed -i "s/database_name_here/${var.db_name}/" wp-config.php
  # sed -i "s/username_here/${var.db_user}/" wp-config.php
  # sed -i "s/password_here/${var.db_password}/" wp-config.php

  # # ディレクトリ権限の設定
  # chown -R apache:apache /var/www/html
  # chmod -R 755 /var/www/html

  # # Apacheの再起動
  # systemctl restart httpd
  # EOF
# }

data "aws_kms_key" "this" {
key_id = "263f293f-abd2-463f-b009-71ed4f47afab"  
}

resource "aws_db_instance" "this" {
  allocated_storage           = 20
  engine                      = "mysql"
  engine_version              = "8.0.39"
  instance_class              = "db.t4g.micro"
  username                    = var.db_user
  manage_master_user_password = true
  kms_key_id                  = data.aws_kms_key.this.arn
  db_subnet_group_name        = aws_db_subnet_group.private_db_subnet_group.name
  vpc_security_group_ids      = [aws_security_group.db.id]
  storage_encrypted = true
  skip_final_snapshot         = true
  deletion_protection = false
  tags = {
    Name = "${var.prefix}-db"
  }

}
