resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16" #change it after the cidr range confirmmation
}

resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24" #change it after the cidr range confirmmation
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24" #change it after the cidr range confirmmation
  availability_zone = "us-east-1b"
}

resource "aws_route_table" "second_rt" {
 vpc_id = aws_vpc.main.id
 
 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = var.tgw_id
 }
}

resource "aws_route_table_association" "subnet1_assoc" {
 subnet_id      = aws_subnet.subnet1.id
 route_table_id = aws_route_table.second_rt.id
}

resource "aws_route_table_association" "subnet2_assoc" {
 subnet_id      = aws_subnet.subnet2.id
 route_table_id = aws_route_table.second_rt.id
}


resource "aws_security_group" "allow" {
  name        = "allow"
  description = "Allow inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id

}

resource "aws_vpc_security_group_ingress_rule" "allow_ipv4" {
  security_group_id = aws_security_group.allow.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

# resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
#   security_group_id = aws_security_group.allow.id
#   cidr_ipv4         = "0.0.0.0/0"
#   ip_protocol       = "-1" # semantically equivalent to all ports
# }
