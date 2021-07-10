terraform {
  backend "s3" {
  
    bucket  = "bar"
    key     = "states/vpc.tfstate"
    region  = "us-east-1"
    
    profile = "foo"
  }
}

module "vpc" {
    source = "github.com/danilo-lopes/vpc"

    aws_profile_name = { AWS_PROFILE = "foo" }

    name = "foo-vpc"
    aws_region = "us-east-1"
    cidr = "192.168.216.0/22"
    azs = [
        "us-east-1a",
        "us-east-1c",
        "us-east-1d"
    ]
    private_subnets = [
        "192.168.216.0/24", 
        "192.168.217.0/24"
    ]
    public_subnets = [
        "192.168.218.0/24",
        "192.168.219.0/24"
    ]
    tags = {
        "owner" = "foo.bar"
        "team" = "bar"
        "environment" = "hml"
        "managed_by" = "terraform"
    }
    private_subnet_tags = {
        "tier" = "private"
        "kubernetes.io/cluster/" = "shared"
        "kubernetes.io/cluster/foo" = "shared"
        "kubernetes.io/role/internal-elb" = "1"
    }
    public_subnet_tags = {
        "tier" = "public"
        "kubernetes.io/cluster/" = "shared"
        "kubernetes.io/cluster/bar" = "shared"
        "kubernetes.io/role/elb" = "1"
    }
}