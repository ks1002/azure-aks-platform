resource "azurerm_resource_group" "application" {
  name     = "rg-${local.name_prefix}-app"
  location = var.location

  tags = local.common_tags
}

resource "azurerm_resource_group" "management" {
  name     = "rg-${local.name_prefix}-mgmt"
  location = var.location

  tags = local.common_tags
}
