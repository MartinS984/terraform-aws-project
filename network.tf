# network.tf

# 1. The VPC (Virtual Private Cloud)
# This is the main container for your network.
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16" # Defines the IP range (65,536 IPs)

  tags = {
    Name = "devops-project-vpc"
  }
}

# 2. The Public Subnet
# A smaller part of the VPC where our Web Server will live.
# We set 'map_public_ip_on_launch' to true so our server gets a public IP.
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.1.0/24" # Range for this specific subnet (256 IPs)
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a" # We pin it to a specific zone

  tags = {
    Name = "devops-public-subnet"
  }
}

# 3. Internet Gateway (IGW)
# Without this, the VPC is completely cut off from the internet.
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "devops-igw"
  }
}

# 4. Route Table
# This tells the network: "If traffic wants to go to 0.0.0.0/0 (Internet), send it to the IGW."
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "devops-public-rt"
  }
}

# 5. Route Table Association
# Connects the "Hallway" (Route Table) to the "Room" (Subnet).
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}