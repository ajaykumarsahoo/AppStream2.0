# Example: Data source for AWS region

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

# Get default VPC

data "aws_vpc" "default" {
  default = true
}

# Get public subnets in the default VPC

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
  filter {
    name   = "default-for-az"
    values = ["true"]
  }
}

data "aws_appstream_image" "latest_win_server_2019" {
  name_regex = "^AppStream-WinServer2019*"
  most_recent = true
}

data "aws_subnet" "supported_az_a" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
  filter {
    name   = "availability-zone"
    values = ["ap-south-1a"]
  }
}

data "aws_subnet" "supported_az_b" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
  filter {
    name   = "availability-zone"
    values = ["ap-south-1b"]
  }
}
