# The virtual private gateway instance
resource "aws_vpn_gateway" "vpn_gateway_main" {
  availability_zone = "${var.region}${var.aws_availability_zone}"

	tags = {
    Name = "vpn_gateway_main"
}
}

# Attach the VPN gateway to the VPC
resource "aws_vpn_gateway_attachment" "vpn_vpc_attachment" {
  vpc_id         = var.VPC_A
  vpn_gateway_id = aws_vpn_gateway.vpn_gateway_main.id
}

# Automatically propagate routes between the VPN gateway and the
# necessary route tables
resource "aws_vpn_gateway_route_propagation" "the_route_propagation" {
  count = length(var.route_VPC_A_public-pb)

  vpn_gateway_id = aws_vpn_gateway.vpn_gateway_main.id
  route_table_id = var.route_VPC_A_public-pb[count.index]
}




resource "aws_vpn_connection" "vpn_connection_main" {
  vpn_gateway_id      = aws_vpn_gateway.vpn_gateway_main.id
  customer_gateway_id = aws_customer_gateway.the_customer_gateway.id
  type                = "ipsec.1"
  static_routes_only  = var.static_routes_only

	tags = {
    Name = "vpn_connection_main"
}
}

# Create routes for traffic that should be routed through the tunnel
resource "aws_vpn_connection_route" "the_vpn_route" {
  count = length(var.remote_cidr_blocks)

  destination_cidr_block = var.remote_cidr_blocks[count.index]
  vpn_connection_id      = aws_vpn_connection.vpn_connection_main.id
}