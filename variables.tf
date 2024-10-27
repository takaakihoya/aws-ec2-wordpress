variable "region" {
  description = "リソースを作成するリージョン。拘りがなければ東京リージョンでOK"
  default     = "ap-northeast-1"
}

variable "profile" {
  description = "リソースの作成に使用するAWSのプロファイル名。terraform.tfvarsで設定する"
  type        = string
}

variable "my_ip" {
  description = "自宅のIPアドレス。セキュリティグループの設定に使用する。terraform.tfvarsで設定する"
  type        = string
}

variable "prefix" {
  description = "リソースに付与するプレフィックス。terraform.tfvarsで設定する"
  type        = string
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "VPCのCIDRブロック。既に使用されているCIDRブロックと重複しないように設定する"
  type        = string
}

variable "db_name" {
  type        = string
  description = "EC2インスタンスに作成するWordPressのデータベース名"
  sensitive   = true # セキュアに取り扱う
}

variable "db_user" {
  type        = string
  description = "WordPressのデータベースユーザー名"
  sensitive   = true # セキュアに取り扱う
}

variable "db_password" {
  type        = string
  description = "WordPressのデータベースユーザーのパスワード"
  sensitive   = true # セキュアに取り扱う
}

variable "db_root_password" {
  type        = string
  description = "MariaDBのrootユーザーのパスワード"
  sensitive   = true # セキュアに取り扱う
}
