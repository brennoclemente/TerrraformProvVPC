#VPC_A-to_VPC_B

resource "aws_vpc_peering_connection" "VPC_A_to_VPC_B" {
  peer_owner_id = aws_vpc.VPC_A.id
  peer_vpc_id   = aws_vpc.VPC_B.id
  vpc_id        = aws_vpc.VPC_A_to_VPC_B.id

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }
}