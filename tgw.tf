###########################
# Transit Gateway Section #
###########################

# Transit Gateway
## a more elaborated setup where
## - Dev VPCs can reach themselves and the Shared VPC
## - the Shared VPC can reach all VPCs
## - the Prod VPC can only reach the Shared VPC
resource "aws_ec2_transit_gateway" "tgw-vpc-main" {
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"
  tags                            = {
    Name                          = "tgw-vpc-main"
  }
}

# VPC attachment

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-att-vpc-1" {
  subnet_ids         = ["${aws_subnet.VPC_A_publicsCIDRblock.id}", "${aws_subnet.VPC_A_privatesCIDRblock.id}", "${aws_subnet.VPC_A_dmzCIDRblock.id}"]
  transit_gateway_id = "${aws_ec2_transit_gateway.tgw-vpc-main.id}"
  vpc_id             = "${aws_vpc.VPC_A.id}"
  transit_gateway_default_route_table_association = true
  transit_gateway_default_route_table_propagation = true
  tags               = {
    Name             = "tgw-att-vpc1"
  }
  depends_on = ["aws_ec2_transit_gateway.tgw-vpc-main"]
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-att-vpc-2" {
  subnet_ids         = ["${aws_subnet.VPC_B_publicsCIDRblock.id}", "${aws_subnet.VPC_B_privatesCIDRblock.id}", "${aws_subnet.VPC_B_dmzCIDRblock.id}"]
  transit_gateway_id = "${aws_ec2_transit_gateway.tgw-vpc-main.id}"
  vpc_id             = "${aws_vpc.VPC_B.id}"
  transit_gateway_default_route_table_association = true
  transit_gateway_default_route_table_propagation = true
  tags               = {
    Name             = "tgw-att-vpc2"
  }
  depends_on = ["aws_ec2_transit_gateway.tgw-vpc-main"]
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-att-vpc-3" {
  subnet_ids         = ["${aws_subnet.VPC_C_publicsCIDRblock.id}", "${aws_subnet.VPC_C_privatesCIDRblock.id}", "${aws_subnet.VPC_C_dmzCIDRblock.id}"]
  transit_gateway_id = "${aws_ec2_transit_gateway.tgw-vpc-main.id}"
  vpc_id             = "${aws_vpc.VPC_C.id}"
  transit_gateway_default_route_table_association = true
  transit_gateway_default_route_table_propagation = true
  tags               = {
    Name             = "tgw-att-vpc3"
  }
  depends_on = ["aws_ec2_transit_gateway.tgw-vpc-main"]
}
###