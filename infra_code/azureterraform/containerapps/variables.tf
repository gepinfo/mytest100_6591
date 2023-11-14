# resource group name
variable "resource" {
  description = "Resource Group Name"
  default     = "mytest100CA"
}
# region name
variable "location" {
  description = "Region Name"
  default     = "eastus"
}

variable "subscription_id" {
  default = ""
}
variable "tenant_id" {
  default = ""
}
variable "client_id" {
  default = ""
}
variable "client_secret" {
  default = ""
}

# Container Registry
variable "cr" {
  description = "Container Registry"
  default     = "mytest100"
}

variable "log" {
  description = "Log Analytics Workspace"
  default     = "mytest100LOG"
}

# Container Apps Enviroment
variable "env" {
  description = "Container app env"
  default     = "mytest100ENV"
}




# Container apps mongo service
variable "mongocontainerapp" {
  description = "Container App Name"
  default     = "mongo"
}
variable "mongotargetport" {
  description = "targetport for containerapps"
  default = "27017"
}
variable "mongoexposedport" {
  description = "exposeport for containerapps"
  default = "27017"
}


# Container apps vaulr service
variable "vaulrcontainerapp" {
  description = "Container App Name"
  default     = "vaulr"
}
variable "vaulrtargetport" {
  description = "targetport for containerapps"
  default = "8200"
}
variable "vaulrexposedport" {
  description = "exposeport for containerapps"
  default = "8200"
}

#Container apps vault
variable "vaultcontainerapp" {
  description = "Contianer App Name"
  default     = "vault"
}
variable "vaultimage" {
  description = "Contianer App Image"
  default     = "vault:1.13.3"
}
variable "vault_list" {
  description = "acceptable values"
  type        = map
  default     = {
    name1 = "VAULT_SERVER"
    name2 = "VAULT_DEV_ROOT_TOKEN_ID"
    value1 = "http://127.0.0.1:8200"
    value2 = "vault-geppetto-2021"
    port = 8200
  }
}

# Container apps authproxy service
variable "authproxycontainerapp" {
  description = "Container App Name"
  default     = "authproxy"
}
variable "authproxytargetport" {
  description = "targetport for containerapps"
  default = "8001"
}
variable "authproxyexposedport" {
  description = "exposeport for containerapps"
  default = "8001"
}


# Container apps securitymanager service
variable "securitymanagercontainerapp" {
  description = "Container App Name"
  default     = "securitymanager"
}
variable "securitymanagertargetport" {
  description = "targetport for containerapps"
  default = "8003"
}
variable "securitymanagerexposedport" {
  description = "exposeport for containerapps"
  default = "8003"
}


# Container apps systemcredentialmanager service
variable "systemcredentialmanagercontainerapp" {
  description = "Container App Name"
  default     = "systemcredentialmanager"
}
variable "systemcredentialmanagertargetport" {
  description = "targetport for containerapps"
  default = "8005"
}
variable "systemcredentialmanagerexposedport" {
  description = "exposeport for containerapps"
  default = "8005"
}


# Container apps gcam service
variable "gcamcontainerapp" {
  description = "Container App Name"
  default     = "gcam"
}
variable "gcamtargetport" {
  description = "targetport for containerapps"
  default = "8007"
}
variable "gcamexposedport" {
  description = "exposeport for containerapps"
  default = "8007"
}


# Container apps apigateway service
variable "apigatewaycontainerapp" {
  description = "Container App Name"
  default     = "apigateway"
}
variable "apigatewaytargetport" {
  description = "targetport for containerapps"
  default = "8000"
}
variable "apigatewayexposedport" {
  description = "exposeport for containerapps"
  default = "8000"
}


# Container apps systementry service
variable "systementrycontainerapp" {
  description = "Container App Name"
  default     = "systementry"
}
variable "systementrytargetport" {
  description = "targetport for containerapps"
  default = "8010"
}
variable "systementryexposedport" {
  description = "exposeport for containerapps"
  default = "8010"
}


# Container apps gepfilemanager service
variable "gepfilemanagercontainerapp" {
  description = "Container App Name"
  default     = "gepfilemanager"
}
variable "gepfilemanagertargetport" {
  description = "targetport for containerapps"
  default = "3015"
}
variable "gepfilemanagerexposedport" {
  description = "exposeport for containerapps"
  default = "3015"
}



# application vnet 
variable "vnet" {
  description = "Virtual Network Name"
  default     = "mytest100VNET"
}
# container apps Subnet
variable "subnet" {
  description = "Subnet Name"
  default     = "mytest100Subnet"
}

# application expose public IP
variable "publicip" {
  description = "Public Ip"
  default = "mytest100PublicIP"
}

# Application gateway apps
variable "applicationgateway" {
  description = "Application Gateway Name"
  default = "mytest100AGW"
}

#container registry reg
variable "registry" {
  default = "<REGISTRY>"
}
#container registry name
variable "registry_name"{
  default = "<REGISTRY_NAME>"
}
#conatiner registry password
variable "registry_password" {
  default = "<REGISTRY_PASSWORD>"
}


