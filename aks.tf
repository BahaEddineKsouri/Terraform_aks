resource "azurerm_resource_group" "bek" {
  name     = "bek-resources"
  location = "West Europe"
}

resource "azurerm_kubernetes_cluster" "bek" {
  name                = "bek-aks1"
  location            = azurerm_resource_group.bek.location
  resource_group_name = azurerm_resource_group.bek.name
  dns_prefix          = "bekaks1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.bek.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.bek.kube_config_raw

  sensitive = true
}