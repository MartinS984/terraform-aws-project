#!/bin/bash
# install_nginx.sh

# Update package lists
sudo apt-get update

# Install Nginx
sudo apt-get install -y nginx

# Start Nginx immediately
sudo systemctl start nginx
sudo systemctl enable nginx

# Create a custom homepage so we know it worked
echo "<h1>Project Deployed Successfully!</h1><p>Running on Terraform & AWS Free Tier</p>" | sudo tee /var/www/html/index.html