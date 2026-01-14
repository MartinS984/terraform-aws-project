# compute.tf

# 1. Get the latest Ubuntu 24.04 AMI (Free Tier Eligible)
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical (The company that makes Ubuntu)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# 2. Security Group (The Firewall)
resource "aws_security_group" "web_sg" {
  name        = "web-server-sg"
  description = "Allow HTTP and SSH"
  vpc_id      = aws_vpc.main_vpc.id # Reference the VPC we built earlier

  # Allow HTTP (Web traffic)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SSH (Login access)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow Server to talk to the internet (updates, etc)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 3. The Server (EC2 Instance)
resource "aws_instance" "web_server" {
  ami           = data.aws_ami.ubuntu.id # Use the ID found above
  instance_type = "t2.micro"             # <--- FREE TIER ELIGIBLE
  subnet_id     = aws_subnet.public_subnet.id
  
  # Attach the firewall
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  # Attach the install script
  user_data = file("install_nginx.sh")

  tags = {
    Name = "DevOps-FreeTier-Server"
  }
}

# 4. Print the IP address at the end
output "web_server_url" {
  value = "http://${aws_instance.web_server.public_ip}"
}