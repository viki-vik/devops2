module "vpc" {
  source = "../modules/vpc"
  # Module inputs
}

module "eks" {
  source = "../modules/eks"

  vpc_id     = "vpc-02c42497a5d880aa4"
  subnet_ids = ["subnet-abcde012", "subnet-bcde012a", "subnet-fghi345a"]
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
