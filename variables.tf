variable "region" {
	default = "us-east-1"
}
variable "dnsSupport" {
	default = "true"
}
variable "dnsHostNames" {
	default = "true"
}
variable "instaceTenancy" {
	default = "default"
}
variable "availabilityZone" {
  type    = list(string)
  default = ["us-east-1a","us-east-1b","us-east-1cus-east-1dus-east-1e","us-east-1f"]
}
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








#Variaveis de gestão

variable "chaveacesso" {
	description = "Digitar a access key"
	type = string
}

variable "chavesecreta" {
	description = "Digitar a secret key"
	type = string
}