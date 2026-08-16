resource "azurerm_virtual_network" "application" {
  name                = "vnet-${local.name_prefix}-app"
  location            = azurerm_resource_group.application.location
  resource_group_name = azurerm_resource_group.application.name

  address_space = var.app_vnet_address_space

  tags = local.common_tags
}

resource "azurerm_virtual_network" "management" {
  name                = "vnet-${local.name_prefix}-mgmt"
  location            = azurerm_resource_group.management.location
  resource_group_name = azurerm_resource_group.management.name

  address_space = var.management_vnet_address_space

  tags = local.common_tags
}

resource "azurerm_subnet" "azure_firewall" {
  name = "AzureFirewallSubnet"

  resource_group_name  = azurerm_resource_group.application.name
  virtual_network_name = azurerm_virtual_network.application.name

  address_prefixes = var.firewall_subnet_address_prefixes
}

resource "azurerm_subnet" "aks" {
  name = "snet-aks"

  resource_group_name  = azurerm_resource_group.application.name
  virtual_network_name = azurerm_virtual_network.application.name

  address_prefixes = var.aks_subnet_address_prefixes
}

resource "azurerm_subnet" "private_endpoints" {
  name = "snet-private-endpoints"

  resource_group_name  = azurerm_resource_group.application.name
  virtual_network_name = azurerm_virtual_network.application.name

  address_prefixes = var.private_endpoint_subnet_address_prefixes
}

resource "azurerm_subnet" "management" {
  name = "snet-management"

  resource_group_name  = azurerm_resource_group.management.name
  virtual_network_name = azurerm_virtual_network.management.name

  address_prefixes = var.management_subnet_address_prefixes
}
