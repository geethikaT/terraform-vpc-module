# Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

   tags = {
    Name = "${var.product}.${var.environment}-public-rt"
  }
}
# Private Route Table - they use the default route table 
resource "aws_default_route_table" "private_route" {
  default_route_table_id = "${aws_vpc.vpc.default_route_table_id}"

 tags = {
    Name = "${var.product}.${var.environment}-private_route"
  }
}

#Associate Public Subnet with Public Route Table

resource "aws_route_table_association" "public_subnet_assoc" {
  count          = length(split(",", var.public_subnets))
  route_table_id = element(aws_route_table.public_rt.*.id, count.index)
  subnet_id      = element(aws_subnet.public_subnets.*.id, count.index)
}


#Associate Public Subnet with Public Route Table
resource "aws_route_table_association" "private_subnet_assoc" {
  count          = length(split(",", var.private_subnets))
  route_table_id = element(aws_default_route_table.private_route.*.id, count.index)
  subnet_id      = element(aws_subnet.private_subnets.*.id, count.index)
}

