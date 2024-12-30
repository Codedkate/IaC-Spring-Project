resource "azurerm_resource_group" "SpringRG" {
  name     = "springrg"
  location = "Central US"
}

resource "azurerm_kubernetes_cluster" "Springcluster" {
  name                = "springcluster1"
  location            = azurerm_resource_group.SpringRG.location
  resource_group_name = azurerm_resource_group.SpringRG.name
  dns_prefix          = "springappaks"

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
  value     = azurerm_kubernetes_cluster.Springcluster.kube_config[0].client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.Springcluster.kube_config_raw

  sensitive = true
}

#Registry

resource "azurerm_container_registry" "springregistry" {
  name                = "springcontainerregistry1"
  resource_group_name = azurerm_resource_group.SpringRG.name
  location            = azurerm_resource_group.SpringRG.location
  sku                 = "Premium"
}