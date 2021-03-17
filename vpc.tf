#VPC_A

resource "aws_vpc" "VPC_A" {
  cidr_block           = var.VPC_A_vpcCIDRblock
  instance_tenancy     = var.instanceTenancy 
  enable_dns_support   = var.dnsSupport 
  enable_dns_hostnames = var.dnsHostNames
tags = {
    Name = "VPC_A"
}
} 
#######################################################
resource "aws_subnet" "subnet-pb" {
  vpc_id                  = aws_vpc.VPC_A.id
  cidr_block              = var.VPC_A_publicsCIDRblock
#  map_public_ip_on_launch = var.mapPublicIP 
  availability_zone       = var.availabilityZone
tags = {
   Name = "Public subnet"
}
}
resource "aws_subnet" "subnet-pv" {
  vpc_id                  = aws_vpc.VPC_A.id
  cidr_block              = var.VPC_A_privatesCIDRblock
#  map_public_ip_on_launch = var.mapPublicIP 
  availability_zone       = var.availabilityZone
tags = {
   Name = "Private subnet"
}
}
resource "aws_subnet" "subnet-db" {
  vpc_id                  = aws_vpc.VPC_A.id
  cidr_block              = var.VPC_A_dmzCIDRblock
#  map_public_ip_on_launch = var.mapPublicIP 
  availability_zone       = var.availabilityZone
tags = {
   Name = "DMZ subnet"
}
}
#######################################################
resource "aws_route_table" "route_public-pb"{
	vpc_id = aws_vpc.VPC_A.id
	
	route {
		destination_cidr_block = var.VPC_A_publicsCIDRblock
		gateway_id = var.VPC_A_defaultGTWpublics
	}
}
resource "aws_route_table" "route_public-pv"{
	vpc_id = aws_vpc.VPC_A.id
	
	route {
		destination_cidr_block = var.VPC_A_privatesCIDRblock
		gateway_id = var.VPC_A_defaultGTWprivates
	}
}
#######################################################
resource "aws_route_table_association" "Public_association" {
  subnet_id      = aws_subnet.subnet-pb.id
  route_table_id = aws_route_table.route_public-pb.id
}


resource "aws_route_table_association" "Private_association" {
  subnet_id      = aws_subnet.subnet-pv.id
  route_table_id = aws_route_table.route_public.id
}
#######################################################


#VPC_B




















