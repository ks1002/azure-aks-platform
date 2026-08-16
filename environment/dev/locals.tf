locals {
  name_prefix = "${var.project_name}-${var.environment}-${var.location_short}"

  common_tags = merge(
    var.tags,
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )
}
