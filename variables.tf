####################################################################################
#VARIAVEIS GLOBAIS PARA TODOS OS VPCs AWS
####################################################################################
variable "region" {
	default = "us-east-1"
}
variable "dnsSupport" {
	default = "true"
}
variable "dnsHostNames" {
	default = "true"
}
variable "instanceTenancy" {
	default = "default"
}
variable "availabilityZone" {
  type    = string
  default = "us-east-1a"
}
variable "chaveacesso" {
	description = "Digitar a access key"
	type = string
}
variable "chavesecreta" {
	description = "Digitar a secret key"
	type = string
}

variable "IDConta" {
	description = "Digitar ID da conta"
	type = number
}

####################################################################################
#Variaveis para o VPC A
####################################################################################

variable "VPC_A_vpcCIDRblock" {
    default = "10.10.0.0/16"
}
variable "VPC_A_publicsCIDRblock" {
    default = "10.10.0.0/24"
}
variable "VPC_A_privatesCIDRblock" {
    default = "10.10.1.0/24"
}
variable "VPC_A_dmzCIDRblock" {
    default = "10.10.2.0/24"
}
variable "VPC_A_defaultGTWpublics" {
    default = "10.10.0.1/24"
}
variable "VPC_A_defaultGTWprivates" {
    default = "10.10.1.1/24"
}
variable "VPC_A_defaultGTWdmz" {
    default = "10.10.2.1/24"
}

####################################################################################
#Variaveis para o VPC B
####################################################################################

variable "VPC_B_vpcCIDRblock" {
    default = "10.20.0.0/16"
}
variable "VPC_B_publicsCIDRblock" {
    default = "10.20.0.0/24"
}
variable "VPC_B_privatesCIDRblock" {
    default = "10.20.1.0/24"
}
variable "VPC_B_dmzCIDRblock" {
    default = "10.20.2.0/24"
}
variable "VPC_B_defaultGTWpublics" {
    default = "10.20.0.1/24"
}
variable "VPC_B_defaultGTWprivates" {
    default = "10.20.1.1/24"
}
variable "VPC_B_defaultGTWdmz" {
    default = "10.20.2.1/24"
}


####################################################################################
#Variaveis para o VPC C
####################################################################################

variable "VPC_C_vpcCIDRblock" {
    default = "10.30.0.0/16"
}
variable "VPC_C_publicsCIDRblock" {
    default = "10.30.0.0/24"
}
variable "VPC_C_privatesCIDRblock" {
    default = "10.30.1.0/24"
}
variable "VPC_C_dmzCIDRblock" {
    default = "10.30.2.0/24"
}
variable "VPC_C_defaultGTWpublics" {
    default = "10.30.0.1/24"
}
variable "VPC_C_defaultGTWprivates" {
    default = "10.30.1.1/24"
}
variable "VPC_C_defaultGTWdmz" {
    default = "10.30.2.1/24"
}


####################################################################################
#VARIAVEIS PARA ROTEAMENTO
####################################################################################

variable "publicdestCIDRblock" {
    default = "0.0.0.0/0"
}
#variable "localdestCIDRblock" {
#    default = "10.0.0.0/16"
#}
variable "ingressCIDRblock" {
    type = list
    default = [ "0.0.0.0/0" ]
}
variable "egressCIDRblock" {
    type = list
    default = [ "0.0.0.0/0" ]
}
#variable "mapPublicIP" {
#    default = true
#}










