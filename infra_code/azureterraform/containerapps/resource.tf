provider "azurerm" {
  features {}

  subscription_id   = var.subscription_id
  tenant_id         = var.tenant_id
  client_id         = var.client_id
  client_secret     = var.client_secret
}
resource "azurerm_resource_group" "example" {
  name     = var.resource
  location = var.location
}
resource "azurerm_virtual_network" "example" {
  name                = var.vnet
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example" {
  name                 = var.subnet
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.0.0/23"]
}
resource "azurerm_subnet" "example_2" {
  name                 = "${var.subnet}-1"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}
resource "azurerm_log_analytics_workspace" "example" {
  name                = var.log
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}
resource "azurerm_container_app_environment" "example" {
  name                       = var.env
  location                   = azurerm_resource_group.example.location
  resource_group_name        = azurerm_resource_group.example.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id
  infrastructure_subnet_id   = azurerm_subnet.example.id
}


#Container apps vault apps 
resource "azurerm_container_app" "vault" {
  name                         = var.vaultcontainerapp
  container_app_environment_id = azurerm_container_app_environment.example.id
  resource_group_name          = azurerm_resource_group.example.name
  revision_mode                = "Single"

  registry {
    server = "docker.io"
  }

  template {
    container {
      name   = "vaultcontainerapp"
      image  = "var.vaultimage"
      cpu    = 0.25
      memory = "0.5Gi"
      
      env {
        name  = var.vault_list["name1"]
        value = var.vault_list["value1"]
      }
      env {
        name  = var.vault_list["name2"]
        value = var.vault_list["value2"]
      }

    }
    revision_suffix = "v1"
    max_replicas = "1"
    min_replicas = "1"
  }
  
  ingress {
    external_enabled = true
    transport        = "http"
    target_port      = var.vault_list["port"]
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }
  provisioner "local-exec" {
    command = "az containerapp ingress update --name $CONTAINER_NAME --resource-group $RG --target-port $TP --exposed-port $EP --transport TCP --type external"
     environment = {
      CONTAINER_NAME = var.vaultcontainerapp
      RG = var.resource
      TP = var.vault_list["port"]
      EP = var.vault_list["port"]
    }
  }

}


# Container apps add all files
resource "azurerm_container_app" "mongo" {
  name                         = var.mongocontainerapp
  container_app_environment_id = azurerm_container_app_environment.example.id
  resource_group_name          = azurerm_resource_group.example.name
  revision_mode                = "Single"
  registry {                
    server               = "mytest100.azurecr.io"
    username             = "mytest100"
    password_secret_name = "mypassword"
  }
  secret {
    name  = "mypassword"
    value = var.registry_password
  }

  template {
    container {
      name   = "mongo"
      image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
    revision_suffix = "v1"
    max_replicas = "1"
    min_replicas = "1"
  }
  
  tags = {
    project_name = "mytest100_6591"
  }
  
  ingress {
    external_enabled = true
    transport        = "http"
    target_port      = 27017
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }
  # provisioner "local-exec" {
   # command = "az containerapp ingress update --name $CONTAINER_NAME --resource-group $RG --target-port $TP --exposed-port $EP --transport TCP --type external"
   #  environment = {
   #   CONTAINER_NAME = var.mongocontainerapp
   #   RG = var.resource
   #   TP = var.mongotargetport
   #   EP = var.mongoexposedport
   # }
  # }

}
resource "azurerm_container_app" "vaulr" {
  name                         = var.vaulrcontainerapp
  container_app_environment_id = azurerm_container_app_environment.example.id
  resource_group_name          = azurerm_resource_group.example.name
  revision_mode                = "Single"
  registry {                
    server               = "mytest100.azurecr.io"
    username             = "mytest100"
    password_secret_name = "mypassword"
  }
  secret {
    name  = "mypassword"
    value = var.registry_password
  }

  template {
    container {
      name   = "vaulr"
      image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
    revision_suffix = "v1"
    max_replicas = "1"
    min_replicas = "1"
  }
  
  tags = {
    project_name = "mytest100_6591"
  }
  
  ingress {
    external_enabled = true
    transport        = "http"
    target_port      = 8200
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }
  # provisioner "local-exec" {
   # command = "az containerapp ingress update --name $CONTAINER_NAME --resource-group $RG --target-port $TP --exposed-port $EP --transport TCP --type external"
   #  environment = {
   #   CONTAINER_NAME = var.vaulrcontainerapp
   #   RG = var.resource
   #   TP = var.vaulrtargetport
   #   EP = var.vaulrexposedport
   # }
  # }

}
resource "azurerm_container_app" "authproxy" {
  name                         = var.authproxycontainerapp
  container_app_environment_id = azurerm_container_app_environment.example.id
  resource_group_name          = azurerm_resource_group.example.name
  revision_mode                = "Single"
  registry {                
    server               = "mytest100.azurecr.io"
    username             = "mytest100"
    password_secret_name = "mypassword"
  }
  secret {
    name  = "mypassword"
    value = var.registry_password
  }

  template {
    container {
      name   = "authproxy"
      image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
    revision_suffix = "v1"
    max_replicas = "1"
    min_replicas = "1"
  }
  
  tags = {
    project_name = "mytest100_6591"
  }
  
  ingress {
    external_enabled = true
    transport        = "http"
    target_port      = 8001
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }
  # provisioner "local-exec" {
   # command = "az containerapp ingress update --name $CONTAINER_NAME --resource-group $RG --target-port $TP --exposed-port $EP --transport TCP --type external"
   #  environment = {
   #   CONTAINER_NAME = var.authproxycontainerapp
   #   RG = var.resource
   #   TP = var.authproxytargetport
   #   EP = var.authproxyexposedport
   # }
  # }

}
resource "azurerm_container_app" "securitymanager" {
  name                         = var.securitymanagercontainerapp
  container_app_environment_id = azurerm_container_app_environment.example.id
  resource_group_name          = azurerm_resource_group.example.name
  revision_mode                = "Single"
  registry {                
    server               = "mytest100.azurecr.io"
    username             = "mytest100"
    password_secret_name = "mypassword"
  }
  secret {
    name  = "mypassword"
    value = var.registry_password
  }

  template {
    container {
      name   = "securitymanager"
      image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
    revision_suffix = "v1"
    max_replicas = "1"
    min_replicas = "1"
  }
  
  tags = {
    project_name = "mytest100_6591"
  }
  
  ingress {
    external_enabled = true
    transport        = "http"
    target_port      = 8003
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }
  # provisioner "local-exec" {
   # command = "az containerapp ingress update --name $CONTAINER_NAME --resource-group $RG --target-port $TP --exposed-port $EP --transport TCP --type external"
   #  environment = {
   #   CONTAINER_NAME = var.securitymanagercontainerapp
   #   RG = var.resource
   #   TP = var.securitymanagertargetport
   #   EP = var.securitymanagerexposedport
   # }
  # }

}
resource "azurerm_container_app" "systemcredentialmanager" {
  name                         = var.systemcredentialmanagercontainerapp
  container_app_environment_id = azurerm_container_app_environment.example.id
  resource_group_name          = azurerm_resource_group.example.name
  revision_mode                = "Single"
  registry {                
    server               = "mytest100.azurecr.io"
    username             = "mytest100"
    password_secret_name = "mypassword"
  }
  secret {
    name  = "mypassword"
    value = var.registry_password
  }

  template {
    container {
      name   = "systemcredentialmanager"
      image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
    revision_suffix = "v1"
    max_replicas = "1"
    min_replicas = "1"
  }
  
  tags = {
    project_name = "mytest100_6591"
  }
  
  ingress {
    external_enabled = true
    transport        = "http"
    target_port      = 8005
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }
  # provisioner "local-exec" {
   # command = "az containerapp ingress update --name $CONTAINER_NAME --resource-group $RG --target-port $TP --exposed-port $EP --transport TCP --type external"
   #  environment = {
   #   CONTAINER_NAME = var.systemcredentialmanagercontainerapp
   #   RG = var.resource
   #   TP = var.systemcredentialmanagertargetport
   #   EP = var.systemcredentialmanagerexposedport
   # }
  # }

}
resource "azurerm_container_app" "gcam" {
  name                         = var.gcamcontainerapp
  container_app_environment_id = azurerm_container_app_environment.example.id
  resource_group_name          = azurerm_resource_group.example.name
  revision_mode                = "Single"
  registry {                
    server               = "mytest100.azurecr.io"
    username             = "mytest100"
    password_secret_name = "mypassword"
  }
  secret {
    name  = "mypassword"
    value = var.registry_password
  }

  template {
    container {
      name   = "gcam"
      image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
    revision_suffix = "v1"
    max_replicas = "1"
    min_replicas = "1"
  }
  
  tags = {
    project_name = "mytest100_6591"
  }
  
  ingress {
    external_enabled = true
    transport        = "http"
    target_port      = 8007
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }
  # provisioner "local-exec" {
   # command = "az containerapp ingress update --name $CONTAINER_NAME --resource-group $RG --target-port $TP --exposed-port $EP --transport TCP --type external"
   #  environment = {
   #   CONTAINER_NAME = var.gcamcontainerapp
   #   RG = var.resource
   #   TP = var.gcamtargetport
   #   EP = var.gcamexposedport
   # }
  # }

}
resource "azurerm_container_app" "apigateway" {
  name                         = var.apigatewaycontainerapp
  container_app_environment_id = azurerm_container_app_environment.example.id
  resource_group_name          = azurerm_resource_group.example.name
  revision_mode                = "Single"
  registry {                
    server               = "mytest100.azurecr.io"
    username             = "mytest100"
    password_secret_name = "mypassword"
  }
  secret {
    name  = "mypassword"
    value = var.registry_password
  }

  template {
    container {
      name   = "apigateway"
      image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
    revision_suffix = "v1"
    max_replicas = "1"
    min_replicas = "1"
  }
  
  tags = {
    project_name = "mytest100_6591"
  }
  
  ingress {
    external_enabled = true
    transport        = "http"
    target_port      = 8000
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }
  # provisioner "local-exec" {
   # command = "az containerapp ingress update --name $CONTAINER_NAME --resource-group $RG --target-port $TP --exposed-port $EP --transport TCP --type external"
   #  environment = {
   #   CONTAINER_NAME = var.apigatewaycontainerapp
   #   RG = var.resource
   #   TP = var.apigatewaytargetport
   #   EP = var.apigatewayexposedport
   # }
  # }

}
resource "azurerm_container_app" "systementry" {
  name                         = var.systementrycontainerapp
  container_app_environment_id = azurerm_container_app_environment.example.id
  resource_group_name          = azurerm_resource_group.example.name
  revision_mode                = "Single"
  registry {                
    server               = "mytest100.azurecr.io"
    username             = "mytest100"
    password_secret_name = "mypassword"
  }
  secret {
    name  = "mypassword"
    value = var.registry_password
  }

  template {
    container {
      name   = "systementry"
      image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
    revision_suffix = "v1"
    max_replicas = "1"
    min_replicas = "1"
  }
  
  tags = {
    project_name = "mytest100_6591"
  }
  
  ingress {
    external_enabled = true
    transport        = "http"
    target_port      = 8010
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }
  # provisioner "local-exec" {
   # command = "az containerapp ingress update --name $CONTAINER_NAME --resource-group $RG --target-port $TP --exposed-port $EP --transport TCP --type external"
   #  environment = {
   #   CONTAINER_NAME = var.systementrycontainerapp
   #   RG = var.resource
   #   TP = var.systementrytargetport
   #   EP = var.systementryexposedport
   # }
  # }

}
resource "azurerm_container_app" "gepfilemanager" {
  name                         = var.gepfilemanagercontainerapp
  container_app_environment_id = azurerm_container_app_environment.example.id
  resource_group_name          = azurerm_resource_group.example.name
  revision_mode                = "Single"
  registry {                
    server               = "mytest100.azurecr.io"
    username             = "mytest100"
    password_secret_name = "mypassword"
  }
  secret {
    name  = "mypassword"
    value = var.registry_password
  }

  template {
    container {
      name   = "gepfilemanager"
      image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
    revision_suffix = "v1"
    max_replicas = "1"
    min_replicas = "1"
  }
  
  tags = {
    project_name = "mytest100_6591"
  }
  
  ingress {
    external_enabled = true
    transport        = "http"
    target_port      = 3015
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }
  # provisioner "local-exec" {
   # command = "az containerapp ingress update --name $CONTAINER_NAME --resource-group $RG --target-port $TP --exposed-port $EP --transport TCP --type external"
   #  environment = {
   #   CONTAINER_NAME = var.gepfilemanagercontainerapp
   #   RG = var.resource
   #   TP = var.gepfilemanagertargetport
   #   EP = var.gepfilemanagerexposedport
   # }
  # }

}
