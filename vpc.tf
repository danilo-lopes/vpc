resource "aws_vpc" "vpc" {
    cidr_block                       = var.cidr
    instance_tenancy                 = var.instance_tenancy
    enable_dns_hostnames             = var.enable_dns_hostnames
    enable_dns_support               = var.enable_dns_support
    enable_classiclink               = var.enable_classiclink
    enable_classiclink_dns_support   = var.enable_classiclink_dns_support
    assign_generated_ipv6_cidr_block = var.enable_ipv6

    # tags = {
    #     Name                     = "${var.eks_cluster_name}-vpc",
    #     owner                    = var.owner,
    #     environment              = var.environment
    #     managed_by               = "terraform",
    #     "kubernetes.io/cluster/" = "shared"
    # }

    tags = merge(
        { 
            "Name": "${var.name}-vpc"
        },
        var.tags,
        var.vpc_tags
    )
}

resource "aws_subnet" "private" {
    count                   = length(var.private_subnets)

    cidr_block              = var.private_subnets[count.index]
    vpc_id                  = aws_vpc.vpc.id
    map_public_ip_on_launch = false
    availability_zone       = var.azs[count.index]

    # tags = {
    #     Name                                            = "${var.eks_cluster_name}-private-subnet-${count.index + 1}"
    #     owner                                           = var.owner,
    #     Tier                                            = "private",
    #     environment                                     = var.environment,
    #     managed_by                                      = "terraform",
    #     "kubernetes.io/cluster/"                        = "shared",
    #     "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared",
    #     "kubernetes.io/role/internal-elb"               = "1"
    # }
    tags = merge(
        {
            "Name" : "${var.name}-private-subnet-${count.index + 1}"
        },
        var.tags,
        var.private_subnet_tags
    )
}

resource "aws_subnet" "public" {
    count                   = length(var.public_subnets)

    cidr_block              = element(var.public_subnets, count.index)
    vpc_id                  = aws_vpc.vpc.id
    map_public_ip_on_launch = true
    availability_zone       = var.azs[count.index]

    # tags = {
    #     Name                                            = "${var.eks_cluster_name}-public-subnet-${count.index + 1}"
    #     Tier                                            = "public",
    #     owner                                           = var.owner,
    #     environment                                     = var.environment,
    #     managed_by                                      = "terraform",
    #     "kubernetes.io/cluster/"                        = "shared",
    #     "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared",
    #     "kubernetes.io/role/elb"                        = "1"
    # }

    tags = merge(
        {
            "Name" : "${var.name}-public-subnet-${count.index + 1}"
        },
        var.tags,
        var.public_subnet_tags
    )
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id

    # tags = {
    #     Name                     = "${var.eks_cluster_name}-igw",
    #     environment              = var.environment,
    #     owner                    = var.owner,
    #     managed_by               = "terraform",
    #     "kubernetes.io/cluster/" = "shared"
    # }

    tags = merge(
        {
            "Name" : "${var.name}-igw"
        },
        var.tags,
        var.igw_tags
    )
}

resource "aws_nat_gateway" "ntg" {
    allocation_id = aws_eip.eip.id
    subnet_id     = aws_subnet.public[0].id

    # tags = {
    #     Name                     = "${var.eks_cluster_name}-ntg",
    #     owner                    = var.owner,
    #     environment              = var.environment,
    #     managed_by               = "terraform",
    #     "kubernetes.io/cluster/" = "shared"
    # }

    tags = merge(
        {
            "Name" : "${var.name}-ntg"
        },
        var.tags,
        var.ntg_tags
    )
}

resource "aws_eip" "eip" {
    vpc = true

    # tags = {
    #     Name                     = "${var.eks_cluster_name}-eip",
    #     owner                    = var.owner,
    #     environment              = var.environment,
    #     managed_by               = "terraform",
    #     "kubernetes.io/cluster/" = "shared"
    # }

    tags = merge(
        {
            "Name" : "${var.name}-eip"
        },
        var.tags,
        var.eip_tags
    )
}

resource "aws_route_table" "private" {
    depends_on         = [
        aws_nat_gateway.ntg
    ]

    vpc_id             = aws_vpc.vpc.id

    route {
        cidr_block     = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.ntg.id
    }

    # tags = {
    #     Name                     = "${var.eks_cluster_name}-private-rt",
    #     owner                    = var.owner,
    #     environment              = var.environment,
    #     managed_by               = "terraform",
    #     "kubernetes.io/cluster/" = "shared"
    # }

    tags = merge(
        {
            "Name" : "${var.name}-private-rt"
        },
        var.tags,
        var.private_route_table_tags
    )
}

resource "aws_route_table" "public" {
    depends_on     = [
        aws_internet_gateway.igw
    ]

    vpc_id         = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    # tags = {
    #     Name                     = "${var.eks_cluster_name}-public-rt",
    #     owner                    = var.owner,
    #     environment              = var.environment,
    #     managed_by               = "terraform",
    #     "kubernetes.io/cluster/" = "shared"
    # }

    tags = merge(
        {
            "Name" : "${var.name}-public-rt"
        },
        var.tags,
        var.public_route_table_tags
    )
}

resource "aws_route_table_association" "private" {
    count          = length(var.private_subnets)

    subnet_id      = element(aws_subnet.private.*.id, count.index)
    route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public" {
    count          = length(var.public_subnets)

    subnet_id      = element(aws_subnet.public.*.id, count.index)
    route_table_id = aws_route_table.public.id
}