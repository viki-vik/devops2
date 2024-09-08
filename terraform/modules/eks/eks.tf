module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.18.0"

  # Cluster name and version
  cluster_name    = "devops2-eks-cluster"
  cluster_version = "1.30"

  # Public access to the cluster API endpoint
  cluster_endpoint_public_access = true

  # VPC and subnet configurations
  vpc_id                   = var.vpc_id
  subnet_ids               = var.subnet_ids
  control_plane_subnet_ids = var.control_plane_subnet_ids

  # EKS Managed Node Groups configuration
  node_groups = {
    example = {
      desired_capacity = 2
      max_capacity     = 10
      min_capacity     = 2
      instance_types   = ["t3.medium"]
      ami_type         = "AL2023_x86_64_STANDARD"
    }
  }

  # Enable admin permissions for the cluster creator
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

  # Tags
  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
