###########################
# Transit Gateway Section #
###########################

# Transit Gateway

resource "aws_ec2_transit_gateway" "tgw-vpc-main" {
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
  tags                            = {
    Name                          = "tgw-vpc-main"
  }
}

# VPC attachment

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-att-vpc-A" {
  subnet_ids         = ["${aws_subnet.VPC_A_publicsCIDRblock.id}", "${aws_subnet.VPC_A_privatesCIDRblock.id}", "${aws_subnet.VPC_A_dmzCIDRblock.id}"]
  transit_gateway_id = "${aws_ec2_transit_gateway.tgw-vpc-main.id}"
  vpc_id             = "${aws_vpc.VPC_A.id}"
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false
  tags               = {
    Name             = "tgw-att-vpc-A"
  }
  depends_on = ["aws_ec2_transit_gateway.tgw-vpc-main"]
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-att-vpc-B" {
  subnet_ids         = ["${aws_subnet.VPC_B_publicsCIDRblock.id}", "${aws_subnet.VPC_B_privatesCIDRblock.id}", "${aws_subnet.VPC_B_dmzCIDRblock.id}"]
  transit_gateway_id = "${aws_ec2_transit_gateway.tgw-vpc-main.id}"
  vpc_id             = "${aws_vpc.VPC_B.id}"
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false
  tags               = {
    Name             = "tgw-att-vpc-B"
  }
  depends_on = ["aws_ec2_transit_gateway.tgw-vpc-main"]
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-att-vpc-C" {
  subnet_ids         = ["${aws_subnet.VPC_C_publicsCIDRblock.id}", "${aws_subnet.VPC_C_privatesCIDRblock.id}", "${aws_subnet.VPC_C_dmzCIDRblock.id}"]
  transit_gateway_id = "${aws_ec2_transit_gateway.tgw-vpc-main.id}"
  vpc_id             = "${aws_vpc.VPC_C.id}"
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false
  tags               = {
    Name             = "tgw-att-vpc-C"
  }
  depends_on = ["aws_ec2_transit_gateway.tgw-vpc-main"]
}


# Route Tables

resource "aws_ec2_transit_gateway_route_table" "tgw-public-rt" {
  transit_gateway_id = "${aws_ec2_transit_gateway.tgw-vpc-rt.id}"
  tags               = {
    Name             = "tgw-vpc-rt"
  }
  depends_on = ["aws_ec2_transit_gateway.tgw-vpc-main"]
}

resource "aws_ec2_transit_gateway_route_table" "tgw-private-rt" {
  transit_gateway_id = "${aws_ec2_transit_gateway.tgw-vpc-main.id}"
  tags               = {
    Name             = "tgw-private-rt"
  }
  depends_on = ["aws_ec2_transit_gateway.tgw-vpc-main"]
}

resource "aws_ec2_transit_gateway_route_table" "tgw-dmz-rt" {
  transit_gateway_id = "${aws_ec2_transit_gateway.tgw-vpc-main.id}"
  tags               = {
    Name             = "tgw-dmz-rt"
  }
  depends_on = ["aws_ec2_transit_gateway.tgw-vpc-main"]
}
# Route Tables Associations

resource "aws_ec2_transit_gateway_route_table_association" "tgw-rt-vpc-A-assoc" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc-1.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.tgw-public-main.id}"
}

resource "aws_ec2_transit_gateway_route_table_association" "tgw-rt-vpc-B-assoc" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc-2.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.tgw-private-rt.id}"
}

resource "aws_ec2_transit_gateway_route_table_association" "tgw-rt-vpc-C-assoc" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc-3.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.tgw-dmz-rt.id}"
}

# Route Tables Propagations

resource "aws_ec2_transit_gateway_route_table_propagation" "tgw-rt-public-to-vpc-A" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc-A.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.tgw-public-rt.id}"
}

resource "aws_ec2_transit_gateway_route_table_propagation" "tgw-rt-public-to-vpc-B" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc-B.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.tgw-public-rt.id}"
}
resource "aws_ec2_transit_gateway_route_table_propagation" "tgw-rt-public-to-vpc-C" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc-C.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.tgw-public-rt.id}"
}

resource "aws_ec2_transit_gateway_route_table_propagation" "tgw-rt-shared-to-vpc-1" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc-1.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.tgw-shared-rt.id}"
}

resource "aws_ec2_transit_gateway_route_table_propagation" "tgw-rt-shared-to-vpc-2" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc-2.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.tgw-shared-rt.id}"
}

resource "aws_ec2_transit_gateway_route_table_propagation" "tgw-rt-shared-to-vpc-4" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc-4.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.tgw-shared-rt.id}"
}

resource "aws_ec2_transit_gateway_route_table_propagation" "tgw-rt-prod-to-vpc-3" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc-3.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.tgw-prod-rt.id}"
}


