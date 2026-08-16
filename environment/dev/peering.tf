resource "azurerm_virtual_network_peering" "application_to_management" {
  name = "peer-app-to-mgmt"

  resource_group_name  = azurerm_resource_group.application.name
  virtual_network_name = azurerm_virtual_network.application.name

  remote_virtual_network_id = azurerm_virtual_network.management.id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "management_to_application" {
  name = "peer-mgmt-to-app"

  resource_group_name  = azurerm_resource_group.management.name
  virtual_network_name = azurerm_virtual_network.management.name

  remote_virtual_network_id = azurerm_virtual_network.application.id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}
