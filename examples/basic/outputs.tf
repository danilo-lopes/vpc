output vpc_id {
    value = module.vpc.vpc_id
}

output vpc_arn {
    value = module.vpc.vpc_arn
}

output vpc_cidr_block {
    value = module.vpc.vpc_cidr_block
}

output private_subnets_id {
    value = module.vpc.private_subnets_id
}

output private_subnets_arn {
    value = module.vpc.private_subnets_arn
}

output private_subnets_cidr_block {
    value = module.vpc.private_subnets_cidr_block
}

output public_subnets_id {
    value = module.vpc.public_subnets_id
}

output public_subnets_arn {
    value = module.vpc.public_subnets_arn
}

output public_subnets_cidr_block {
    value = module.vpc.public_subnets_cidr_block
}