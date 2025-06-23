#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#

resource "aws_vpc" "tsp-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = tomap({
    "Name" = "tsp-eks-node",
    "kubernetes.io/cluster/${var.cluster-name}" = "shared",
  })
}

resource "aws_subnet" "tsp-vpc" {
  count = 2

  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.tsp-vpc.id

  tags = tomap({
    "Name" = "tsp-eks-node",
    "kubernetes.io/cluster/${var.cluster-name}" = "shared",
  })
}

resource "aws_internet_gateway" "tsp-vpc" {
  vpc_id = aws_vpc.tsp-vpc.id

  tags = {
    Name = "tsp-vpc"
  }
}

resource "aws_route_table" "tsp-vpc" {
  vpc_id = aws_vpc.tsp-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tsp-vpc.id
  }
}

resource "aws_route_table_association" "tsp-vpc" {
  count = 2

  subnet_id      = aws_subnet.tsp-vpc.*.id[count.index]
  route_table_id = aws_route_table.tsp-vpc.id
}
