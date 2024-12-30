resource "azurerm_resource_group" "springapprg" {
  name     = "springapprg"
  location = "Central US"
}

resource "azurerm_kubernetes_cluster" "springcluster" {
  name                = "springcluster1"
  location            = azurerm_resource_group.springapprg.location
  resource_group_name = azurerm_resource_group.springapprg.name
  dns_prefix          = "springcluster1"

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
  value     = azurerm_kubernetes_cluster.springcluster.kube_config[0].client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.springcluster.kube_config_raw

  sensitive = true
}

#Registry

resource "azurerm_container_registry" "springregistry" {
  name                = "springcontainerregistry1"
  resource_group_name = azurerm_resource_group.springapprg.name
  location            = azurerm_resource_group.springapprg.location
  sku                 = "Premium"
}