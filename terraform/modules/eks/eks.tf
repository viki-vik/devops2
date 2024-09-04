module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.18.0"

  cluster_name    = "devops2-eks-cluster"
  cluster_version = "1.30"

  cluster_endpoint_public_access = true
  cluster_endpoint_private_access = false  # Set to true if you need private endpoint access

  vpc_id                   = "vpc-02c42497a5d880aa4"
  subnet_ids               = ["subnet-abcde012", "subnet-bcde012a", "subnet-fghi345a"]
  control_plane_subnet_ids = ["subnet-xyzde987", "subnet-slkjf456", "subnet-qeiru789"]

  # EKS Managed Node Group(s)
  node_groups = {
    example = {
      desired_capacity = 2
      max_capacity     = 10
      min_capacity     = 2
      instance_types   = ["m5.xlarge"]
      ami_type         = "AL2023_x86_64_STANDARD"  # Specify the AMI type for EKS managed node groups
    }
  }

  # Access configuration
  enable_cluster_creator_admin_permissions = true

  # IAM roles and policies for cluster access
  access_entries = {
    example = {
      principal_arn     = "arn:aws:iam::123456789012:role/something"
      kubernetes_groups = []
      policy_associations = {
        example = {
          policy_arn = "arn:aws:iam::aws:policy/AmazonEKSViewOnlyAccess"
        }
      }
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }

}
