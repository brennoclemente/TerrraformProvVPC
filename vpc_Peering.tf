#######################################################
#VPC_A_to_VPC_B
#######################################################


resource "aws_vpc_peering_connection" "VPC_A" {
  peer_owner_id = aws_vpc.VPC_A.id
  peer_vpc_id   = aws_vpc.VPC_B.id
  peer_vpc_id	= aws_vpc.VPC_C.id
  vpc_id        = aws_vpc.VPC_A.id

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }
}

#######################################################
#VPC_A_to_VPC_C
#######################################################


#resource "aws_vpc_peering_connection" "VPC_C" {
#  peer_owner_id = aws_vpc.VPC_C.id
#  peer_vpc_id   = aws_vpc.VPC_A.id
#  vpc_id        = aws_vpc.VPC_C.id

#  accepter {
#    allow_remote_vpc_dns_resolution = true
#  }

#  requester {
#    allow_remote_vpc_dns_resolution = true
#  }
#}