#!/bin/bash

# Update packages
sudo apt update -y
sudo apt upgrade -y

# Install Apache
sudo apt install -y apache2

# Enable and start Apache
sudo systemctl enable apache2
sudo systemctl start apache2

# Default page
echo '<h1>Hello World From Web Server</h1>' | sudo tee /var/www/html/index.html

# App1 page
sudo mkdir -p /var/www/html/app1

echo '<!DOCTYPE html>
<html>
<body style="background-color:rgb(250, 210, 210);">
<h1>Welcome to Stack Simplify - APP-1</h1>
<p>Terraform Demo</p>
<p>Application Version: V1</p>
</body>
</html>' | sudo tee /var/www/html/app1/index.html

# Get IMDSv2 token
TOKEN=$(curl -s -X PUT \
  "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

# Save EC2 instance identity document
sudo curl -s \
  -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/dynamic/instance-identity/document \
  -o /var/www/html/app1/metadata.html