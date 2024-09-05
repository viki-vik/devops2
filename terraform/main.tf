module "vpc" {
  source = "../modules/vpc"
  # Module inputs
}

module "eks" {
  source = "../modules/eks"
  vpc_id = module.vpc
  # Module inputs
}

module "alb" {
  source = "../modules/alb"
  vpc_id = module.vpc
  # Module inputs
}

module "route53" {
  source = "../modules/route53"
  vpc_id = module.vpc
  # Module inputs
}
