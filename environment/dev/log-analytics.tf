resource "azurerm_log_analytics_workspace" "main" {
  name                = "law-${local.name_prefix}"
  location            = azurerm_resource_group.management.location
  resource_group_name = azurerm_resource_group.management.name

  sku               = "PerGB2018"
  retention_in_days = 30

  # Cost protection for this personal development lab.
  daily_quota_gb = 0.2

  tags = local.common_tags
}
