resource "azurerm_kubernetes_cluster" "main" {
  name                = "aks-${local.name_prefix}"
  location            = azurerm_resource_group.application.location
  resource_group_name = azurerm_resource_group.application.name

  dns_prefix = "aks-${var.project_name}-${var.environment}"

  sku_tier = "Free"

  default_node_pool {
    name = "system"

    vm_size    = "Standard_D4_v3"
    node_count = 2

    vnet_subnet_id = azurerm_subnet.aks.id

    upgrade_settings {
      max_surge                     = "10%"
      node_soak_duration_in_minutes = 0
    }

  }

  identity {
    type = "UserAssigned"

    identity_ids = [
      azurerm_user_assigned_identity.aks_control_plane.id
    ]
  }

  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"

    pod_cidr       = "10.244.0.0/16"
    service_cidr   = "172.16.0.0/16"
    dns_service_ip = "172.16.0.10"

    load_balancer_sku = "standard"
    outbound_type     = "loadBalancer"
  }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id
  }

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  key_vault_secrets_provider {
    secret_rotation_enabled = false
  }

  tags = local.common_tags

  depends_on = [
    azurerm_role_assignment.aks_subnet_network_contributor
  ]
}

