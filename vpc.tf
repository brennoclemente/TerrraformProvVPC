###############################################################
#PROVISIONAMENTO: VPC_A
###############################################################
resource "aws_vpc" "VPC_A" {
  cidr_block           = var.VPC_A_vpcCIDRblock
  instance_tenancy     = var.instanceTenancy 
  enable_dns_support   = var.dnsSupport 
  enable_dns_hostnames = var.dnsHostNames
tags = {
    Name = "VPC_A"
}
} 
##############################################################
#Criação Subrede Pública no VPC_A
##############################################################
resource "aws_subnet" "VPC_A_subnet-pb" {
  vpc_id                  = aws_vpc.VPC_A.id
  cidr_block              = var.VPC_A_publicsCIDRblock
#  map_public_ip_on_launch = var.mapPublicIP 
  availability_zone       = var.availabilityZone
tags = {
   Name = "Public subnet VPC A"
}
}
##############################################################
#Criação Subrede Privada no VPC_A
##############################################################
resource "aws_subnet" "VPC_A_subnet-pv" {
  vpc_id                  = aws_vpc.VPC_A.id
  cidr_block              = var.VPC_A_privatesCIDRblock
#  map_public_ip_on_launch = var.mapPublicIP 
  availability_zone       = var.availabilityZone
tags = {
   Name = "Private subnet VPC A"
}
}
##############################################################
#Criação Subrede DMZ no VPC_A
##############################################################
resource "aws_subnet" "VPC_A_subnet-db" {
  vpc_id                  = aws_vpc.VPC_A.id
  cidr_block              = var.VPC_A_dmzCIDRblock
#  map_public_ip_on_launch = var.mapPublicIP 
  availability_zone       = var.availabilityZone
tags = {
   Name = "DMZ subnet VPC A"
}
}
##############################################################
#CRIAÇÃO DA TABELA DE ROTEAMENTO DAS SUBREDES PUBLICAS E PRIVADAS
##############################################################
resource "aws_route_table" "route_VPC_A_public-pb"{
	vpc_id = aws_vpc.VPC_A.id
	
	#route {
	#	cidr_block = var.VPC_A_publicsCIDRblock
		#gateway_id = var.VPC_A_defaultGTWpublics
	#}
	
	tags = {
    Name = "Roteamento Publico VPC A"
}
}
resource "aws_route_table" "route_VPC_A_private-pv"{
	vpc_id = aws_vpc.VPC_A.id
	
	#route {
	#	cidr_block = var.VPC_A_privatesCIDRblock
		#gateway_id = var.VPC_A_defaultGTWprivates
	#}
}
##############################################################
#ASSOCIAÇÃO DAS TABELAS DE ROTEAMENTO AS SUBREDES
##############################################################
resource "aws_route_table_association" "Public_association_VPC_A" {
  subnet_id      = aws_subnet.VPC_A_subnet-pb.id
  route_table_id = aws_route_table.route_VPC_A_public-pb.id
}


resource "aws_route_table_association" "Private_association_VPC_A" {
  subnet_id      = aws_subnet.VPC_A_subnet-pv.id
  route_table_id = aws_route_table.route_VPC_A_private-pv.id
}
###############################################################
#FIM DO PROVISIONAMENTO: VPC_A
###############################################################


####################################################################################################################


###############################################################
#PROVISIONAMENTO: VPC_B
###############################################################
resource "aws_vpc" "VPC_B" {
  cidr_block           = var.VPC_B_vpcCIDRblock
  instance_tenancy     = var.instanceTenancy 
  enable_dns_support   = var.dnsSupport 
  enable_dns_hostnames = var.dnsHostNames
tags = {
    Name = "VPC_B"
}
} 
#################################################################
#Criação Subrede Pública no VPC_B
#################################################################
resource "aws_subnet" "VPC_B_subnet-pb" {
  vpc_id                  = aws_vpc.VPC_B.id
  cidr_block              = var.VPC_B_publicsCIDRblock
#  map_public_ip_on_launch = var.mapPublicIP 
  availability_zone       = var.availabilityZone
tags = {
   Name = "Public subnet VPC B"
}
}
#################################################################
#Criação Subrede Privada no VPC_B
#################################################################
resource "aws_subnet" "VPC_B_subnet-pv" {
  vpc_id                  = aws_vpc.VPC_B.id
  cidr_block              = var.VPC_B_privatesCIDRblock
#  map_public_ip_on_launch = var.mapPublicIP 
  availability_zone       = var.availabilityZone
tags = {
   Name = "Private subnet VPC B"
}
}
#################################################################
#Criação Subrede DMZ no VPC_B
#################################################################
resource "aws_subnet" "VPC_B_subnet-db" {
  vpc_id                  = aws_vpc.VPC_B.id
  cidr_block              = var.VPC_B_dmzCIDRblock
#  map_public_ip_on_launch = var.mapPublicIP 
  availability_zone       = var.availabilityZone
tags = {
   Name = "DMZ subnet VPC B"
}
}
#################################################################
#CRIAÇÃO DA TABELA DE ROTEAMENTO DAS SUBREDES PUBLICAS E PRIVADAS
#################################################################
resource "aws_route_table" "route_VPC_B_public-pb"{
	vpc_id = aws_vpc.VPC_B.id
	
	#route {
	#	cidr_block = var.VPC_B_publicsCIDRblock
		#gateway_id = var.VPC_B_defaultGTWpublics
	#}
}
resource "aws_route_table" "route_VPC_B_private-pv"{
	vpc_id = aws_vpc.VPC_B.id
	
	#route {
	#	cidr_block = var.VPC_B_privatesCIDRblock
		#gateway_id = var.VPC_B_defaultGTWprivates
	#}
}
#######################################################
#ASSOCIAÇÃO DAS TABELAS DE ROTEAMENTO AS SUBREDES
#######################################################
resource "aws_route_table_association" "Public_association_VPC_B" {
  subnet_id      = aws_subnet.VPC_B_subnet-pb.id
  route_table_id = aws_route_table.route_VPC_B_public-pb.id
}


resource "aws_route_table_association" "Private_association_VPC_B" {
  subnet_id      = aws_subnet.VPC_B_subnet-pv.id
  route_table_id = aws_route_table.route_VPC_B_private-pv.id
}
###############################################################
#FIM DO PROVISIONAMENTO: VPC_B
###############################################################


####################################################################################################################


###############################################################
#PROVISIONAMENTO: VPC_C
###############################################################
resource "aws_vpc" "VPC_C" {
  cidr_block           = var.VPC_C_vpcCIDRblock
  instance_tenancy     = var.instanceTenancy 
  enable_dns_support   = var.dnsSupport 
  enable_dns_hostnames = var.dnsHostNames
tags = {
    Name = "VPC_C"
}
} 
#################################################################
#Criação Subrede Pública no VPC_C
#################################################################
resource "aws_subnet" "VPC_C_subnet-pb" {
  vpc_id                  = aws_vpc.VPC_C.id
  cidr_block              = var.VPC_C_publicsCIDRblock
#  map_public_ip_on_launch = var.mapPublicIP 
  availability_zone       = var.availabilityZone
tags = {
   Name = "Public subnet VPC C"
}
}
#################################################################
#Criação Subrede Privada no VPC_C
#################################################################
resource "aws_subnet" "VPC_C_subnet-pv" {
  vpc_id                  = aws_vpc.VPC_C.id
  cidr_block              = var.VPC_C_privatesCIDRblock
#  map_public_ip_on_launch = var.mapPublicIP 
  availability_zone       = var.availabilityZone
tags = {
   Name = "Private subnet VPC C"
}
}
#################################################################
#Criação Subrede DMZ no VPC_C
#################################################################
resource "aws_subnet" "VPC_C_subnet-db" {
  vpc_id                  = aws_vpc.VPC_C.id
  cidr_block              = var.VPC_C_dmzCIDRblock
#  map_public_ip_on_launch = var.mapPublicIP 
  availability_zone       = var.availabilityZone
tags = {
   Name = "DMZ subnet VPC C"
}
}
#################################################################
#CRIAÇÃO DA TABELA DE ROTEAMENTO DAS SUBREDES PUBLICAS E PRIVADAS
#################################################################
resource "aws_route_table" "route_VPC_C_public-pb"{
	vpc_id = aws_vpc.VPC_C.id
		
	#route {
	#	cidr_block = var.VPC_C_publicsCIDRblock
		#gateway_id = var.VPC_C_defaultGTWpublics
	#}
}
resource "aws_route_table" "route_VPC_C_private-pv"{
	vpc_id = aws_vpc.VPC_C.id
	
	#route {
	#	cidr_block = var.VPC_C_privatesCIDRblock
	#	#gateway_id = var.VPC_C_defaultGTWprivates
	#}
}
#######################################################
#ASSOCIAÇÃO DAS TABELAS DE ROTEAMENTO AS SUBREDES
#######################################################
resource "aws_route_table_association" "Public_association_VPC_C" {
  subnet_id      = aws_subnet.VPC_C_subnet-pb.id
  route_table_id = aws_route_table.route_VPC_C_public-pb.id
}


resource "aws_route_table_association" "Private_association_VPC_C" {
  subnet_id      = aws_subnet.VPC_C_subnet-pv.id
  route_table_id = aws_route_table.route_VPC_C_private-pv.id
}
###############################################################
#FIM DO PROVISIONAMENTO: VPC_C
###############################################################





