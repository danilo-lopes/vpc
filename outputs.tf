output vpc_id {
    value = aws_vpc.vpc.id
}

output vpc_arn {
    value = aws_vpc.vpc.arn
}

output vpc_cidr_block {
    value = aws_vpc.vpc.cidr_block
}

output private_subnets_id {
    value = aws_subnet.private[*].id
}

output private_subnets_arn {
    value = aws_subnet.private[*].arn
}

output private_subnets_cidr_block {
    value = aws_subnet.private[*].cidr_block
}

output public_subnets_id {
    value = aws_subnet.public[*].id
}

output public_subnets_arn {
    value = aws_subnet.public[*].arn
}

output public_subnets_cidr_block {
    value = aws_subnet.public[*].cidr_block
}