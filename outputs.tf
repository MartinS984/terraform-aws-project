# outputs.tf

output "web_server_public_ip" {
  description = "The raw public IP address of the main server"
  value       = aws_instance.web_server.public_ip
}

output "website_url" {
  description = "Clickable link to access the website"
  value       = "http://${aws_instance.web_server.public_ip}"
}