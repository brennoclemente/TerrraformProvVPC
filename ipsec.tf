#######################################################
# PROVISIONANDO A INSTANCIA DO GATEWAY VPN
#######################################################
resource "aws_vpn_gateway" "vpn_gateway_main" {
  availability_zone = "${var.region}${var.aws_availability_zone}"

	tags = {
    Name = "vpn_gateway_main"
}
}
#######################################################
# ASSOCIANDO A INSTANCIA DE VPN AO VPC
#######################################################
resource "aws_vpn_gateway_attachment" "vpn_vpc_attachment" {
  vpc_id         = aws_vpc.VPC_A.id
  vpn_gateway_id = aws_vpn_gateway.vpn_gateway_main.id
}
#######################################################
# PROPAGAÇÃO AUTOMATICA DE ROTAS ENTRE ENTRE O VPN GATEWAY
# E O VPC
# NECESSÁRIO TABELA DE ROTEAMENTO
#######################################################
resource "aws_vpn_gateway_route_propagation" "the_route_propagation" {
	#alterei a linha abaixo de var. para aws_route_table. 
  count = length(aws_route_table.route_VPC_A_public-pb)

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
#######################################################
# CRIAÇÃO DE ROTAS PARA O TRAFEGO QUE DEVE ACONTECER DENTRO DO TUNEL
#######################################################
resource "aws_vpn_connection_route" "the_vpn_route" {
  count = length(var.remote_cidr_blocks)

  destination_cidr_block = var.remote_cidr_blocks[count.index]
  vpn_connection_id      = aws_vpn_connection.vpn_connection_main.id
}