variable "vpc_id" {
  type        = string
  description = "VPC ID where the EKS and other resources will be deployed"
}

variable "subnet_ids" {
  type        = list(string)
  description = "A list of subnets ID to associate with"
}
