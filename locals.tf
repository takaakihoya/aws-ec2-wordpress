locals {
  public_subnets = {
    public_subnet_1a = {
      availability_zone       = "ap-northeast-1a"
      cider_block             = cidrsubnet(var.vpc_cidr, 8, 0)
      map_public_ip_on_launch = true
      tags = {
        Name = "${var.prefix}-public-1a"
      }
    }
    public_subnet_1c = {
      availability_zone       = "ap-northeast-1c"
      cider_block             = cidrsubnet(var.vpc_cidr, 8, 1)
      map_public_ip_on_launch = true
      tags = {
        Name = "${var.prefix}-public-1c"
      }
    }
  }
}

locals {
  private_subnets = {
    private_subnet_1a = {
      availability_zone       = "ap-northeast-1a"
      cider_block             = cidrsubnet(var.vpc_cidr, 8, 2)
      map_public_ip_on_launch = false
      tags = {
        Name = "${var.prefix}-private-1a"
      }
    }
    private_subnet_1c = {
      availability_zone       = "ap-northeast-1c"
      cider_block             = cidrsubnet(var.vpc_cidr, 8, 3)
      map_public_ip_on_launch = false
      tags = {
        Name = "${var.prefix}-private-1c"
      }
    }
  }
}

locals {
  security_groups = {
    ec2 = {
      name        = "${var.prefix}-ec2-sg"
      description = "Allow  My IP and DB Access"
      ingress = {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["${var.my_ip}/32"]
      }
      egress = {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
      tags = {
        Name = "${var.prefix}-ec2-sg"
      }
    }
    db = {
      name        = "${var.prefix}-db-sg"
      description = "Allow EC2 Access"
      ingress = {
        from_port       = 3306
        to_port         = 3306
        protocol        = "tcp"
        security_groups = [aws_security_group.ec2.id]
      }
      egress = {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    }
  }
}
