locals {
  project_owner = "terraform-aws-ec2"
  cost_center   = "dev"
  managed_by    = "terraform"
}

locals {
  common_tags = {
    Project            = local.project_owner
    CostCenter         = local.cost_center
    ManagedBy          = local.managed_by
    sensitive_variable = var.my_sensitive_variable
  }
}