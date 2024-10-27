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
