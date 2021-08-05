resource "aws_vpc" "vpc" {
  cidr_block       = var.cidr
  instance_tenancy = var.tenancy

  tags = {
    Name = "${var.product}.${var.environment}-vpc"

  }
}


