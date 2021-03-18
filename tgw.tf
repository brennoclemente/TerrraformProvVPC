###########################
# Transit Gateway Section #
#############################
# CRIAÇÃO DO TRANSIT GATEWAY#
#############################
resource "aws_ec2_transit_gateway" "tgw-vpc-main" {
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
  tags                            = {
    Name                          = "tgw-vpc-main"
  }
}
##############################################################
# ASSOCIAÇÃO DO TGW AO VPC
##############################################################
resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-att-vpc-A" {
	#Alterado a linha abaixo onde chamava-se VPC_A_publicsCIDRblock para realmente o id da subrede "VPC_A_subnet-db" 
  subnet_ids         = ["${aws_subnet.VPC_A_subnet-pb.id}", "${aws_subnet.VPC_A_subnet-pv.id}", "${aws_subnet.VPC_A_subnet-db.id}"]
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
	#Alterado a linha abaixo onde chamava-se VPC_B_publicsCIDRblock para realmente o id da subrede "VPC_B_subnet-db"
  subnet_ids         = ["${aws_subnet.VPC_B_subnet-pb.id}", "${aws_subnet.VPC_B_subnet-pv.id}", "${aws_subnet.VPC_B_subnet-db.id}"]
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
	#Alterado a linha abaixo onde chamava-se VPC_C_publicsCIDRblock para realmente o id da subrede "VPC_C_subnet-db"
  subnet_ids         = ["${aws_subnet.VPC_C_subnet-pb.id}", "${aws_subnet.VPC_C_subnet-pv.id}", "${aws_subnet.VPC_C_subnet-db.id}"]
  transit_gateway_id = "${aws_ec2_transit_gateway.tgw-vpc-main.id}"
  vpc_id             = "${aws_vpc.VPC_C.id}"
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false
  tags               = {
    Name             = "tgw-att-vpc-C"
  }
  depends_on = ["aws_ec2_transit_gateway.tgw-vpc-main"]
}

###################################################
# CRIAÇÃO DAS ROUTES TABLES
###################################################
resource "aws_ec2_transit_gateway_route_table" "tgw-public-rt" {
  transit_gateway_id = "${aws_ec2_transit_gateway.tgw-vpc-main.id}"
  tags               = {
    Name             = "tgw-public-rt"
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


#######################################
# ASSOCIAÇÃO DAS TABELAS DE ROTEAMENTO
#######################################
resource "aws_ec2_transit_gateway_route_table_association" "tgw-rt-vpc-A-assoc" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc-A.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.tgw-public-rt.id}"
}

resource "aws_ec2_transit_gateway_route_table_association" "tgw-rt-vpc-B-assoc" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc-B.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.tgw-private-rt.id}"
}

resource "aws_ec2_transit_gateway_route_table_association" "tgw-rt-vpc-C-assoc" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc-C.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.tgw-dmz-rt.id}"
}
######################################
# PROPAGAÇÃO DAS TABELAS DE ROTEAMENTO
######################################

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

resource "aws_ec2_transit_gateway_route_table_propagation" "tgw-rt-private-to-vpc-A" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc-A.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.tgw-private-rt.id}"
}

resource "aws_ec2_transit_gateway_route_table_propagation" "tgw-rt-private-to-vpc-B" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc-B.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.tgw-private-rt.id}"
}

resource "aws_ec2_transit_gateway_route_table_propagation" "tgw-rt-private-to-vpc-C" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc-C.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.tgw-private-rt.id}"
}

resource "aws_ec2_transit_gateway_route_table_propagation" "tgw-rt-dmz-to-vpc-A" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc-A.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.tgw-dmz-rt.id}"
}

resource "aws_ec2_transit_gateway_route_table_propagation" "tgw-rt-dmz-to-vpc-B" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc-B.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.tgw-dmz-rt.id}"
}
resource "aws_ec2_transit_gateway_route_table_propagation" "tgw-rt-dmz-to-vpc-C" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc-C.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.tgw-dmz-rt.id}"
}

