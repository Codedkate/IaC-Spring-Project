resource "azurerm_resource_group" "myspringbootrg" {
  name     = "myspringbootrg"
  location = "Central US"
}


resource "azurerm_kubernetes_cluster" "spring-boot-app-aks-cluster" {
  name                = "spring-boot-app-aks-cluster"
  location            = azurerm_resource_group.myspringbootrg.location
  resource_group_name = azurerm_resource_group.myspringbootrg.name
  dns_prefix          = "springbootappdnsaks"

  default_node_pool {
    name       = "default"
    node_count = 2
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
  value     = azurerm_kubernetes_cluster.Springclusterspring-boot-app-aks-cluster.kube_config[0].client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.spring-boot-app-aks-cluster.kube_config_raw

  sensitive = true
}

#Registry

resource "azurerm_container_registry" "myspringbootrg" {
  name                = "springbootreactacr"
  resource_group_name = azurerm_resource_group.myspringbootrg.name
  location            = azurerm_resource_group.SpringRG.location
  sku                 = "Premium"
}
