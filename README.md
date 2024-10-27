# aws-ec2-wordpress

## 概要
EC2でwordpressを起動させるのに必要なリソースを作成します。
詳細は以下のQiitaの記事を参照してください。
https://qiita.com/hoyat4967/items/074716895f737b79e3ed

## 作成されるリソースタイプ
| リソースタイプ                      | 数   |
|--------------------------------|-----|
| `aws_instance`                 | 1   |
| `aws_iam_role`                | 1   |
| `aws_iam_role_policy_attachment` | 1   |
| `aws_iam_instance_profile`     | 1   |
| `aws_vpc`                      | 1   |
| `aws_subnet`                   | 4   |
| `aws_internet_gateway`         | 1   |
| `aws_route_table`              | 2   |
| `aws_route_table_association`   | 2   |
| `aws_security_group`           | 1   |

## 使い方
### リポジトリをcloneする
1.以下コマンドでリポジトリをcloneする

`git clone https://github.com/takaakihoya/aws-ec2-wordpress.git`

2.以下コマンドでcloneしたディレクトリに以下コマンドでterraform.tfvarsを作成する

`touch terraform.tfvars`

3.terraform.tfvarsファイルを編集する

`terraform.tfvars.sample`の内容に沿って値を入れてください

4.以下コマンドでterraformを初期化する

`terraform init`

5.以下コマンドで作成されるリソースの確認

`terraform plan`

6.以下コマンドでリソースを作成する

`terraform apply`

7.作成したEC2にアクセスする

EC2のパブリックIPを確認し、httpでアクセスします

ex)http://${your_global_ip}

8.wordpressの初期設定

アクセスするとwordpressの初期設定画面に飛ぶので設定


9.記事を書く

ここまで実施すれば記事がかけるようになります。

## 注意点
- EC2をパブリックに公開しているので、securitygroupの設定で自分のPCからのみアクセス許可するようにしてください
- 作成したリソースを放置すると料金が発生します
- 検証が終了したら以下コマンドでリソースの削除を行ってください

    `terraform destroy`