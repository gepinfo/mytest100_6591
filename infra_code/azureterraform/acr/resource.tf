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

resource "azurerm_container_registry" "acr" {
  name                = var.cr
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "Basic"
  admin_enabled       = true
  #provisioner "local-exec" {
   # command = [
   #   
   #   "az acr build --registry $REGISTRY_NAME --image $IMAGE_NAME_mongo DockerfileLocation . ",
   #   
   #   "az acr build --registry $REGISTRY_NAME --image $IMAGE_NAME_vaulr DockerfileLocation . ",
   #   
   #   "az acr build --registry $REGISTRY_NAME --image $IMAGE_NAME_authproxy DockerfileLocation . ",
   #   
   #   "az acr build --registry $REGISTRY_NAME --image $IMAGE_NAME_securitymanager DockerfileLocation . ",
   #   
   #   "az acr build --registry $REGISTRY_NAME --image $IMAGE_NAME_systemcredentialmanager DockerfileLocation . ",
   #   
   #   "az acr build --registry $REGISTRY_NAME --image $IMAGE_NAME_gcam DockerfileLocation . ",
   #   
   #   "az acr build --registry $REGISTRY_NAME --image $IMAGE_NAME_apigateway DockerfileLocation . ",
   #   
   #   "az acr build --registry $REGISTRY_NAME --image $IMAGE_NAME_systementry DockerfileLocation . ",
   #   
   #   "az acr build --registry $REGISTRY_NAME --image $IMAGE_NAME_gepfilemanager DockerfileLocation . ",
   #   
   # ]
   # environment = {
   #   REGISTRY_NAME = var.cr
   #   
   #   IMAGE_NAME_mongo  = "mongo"
   #   
   #   IMAGE_NAME_vaulr  = "vaulr"
   #   
   #   IMAGE_NAME_authproxy  = "authproxy"
   #   
   #   IMAGE_NAME_securitymanager  = "securitymanager"
   #   
   #   IMAGE_NAME_systemcredentialmanager  = "systemcredentialmanager"
   #   
   #   IMAGE_NAME_gcam  = "gcam"
   #   
   #   IMAGE_NAME_apigateway  = "apigateway"
   #   
   #   IMAGE_NAME_systementry  = "systementry"
   #   
   #   IMAGE_NAME_gepfilemanager  = "gepfilemanager"
   #   
   # }
  # }
}
