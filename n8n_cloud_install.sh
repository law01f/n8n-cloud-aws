#!/bin/bash
read -p "Enter your domain or subdomain name (Example:my-n8n.ddns.net): " My_Domain_Or_Subdomain
sudo apt update && sudo apt upgrade -y
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo docker run -d --restart unless-stopped -it --name n8n -p 5678:5678 -e N8N_HOST="$My_Domain_Or_Subdomain" -e WEBHOOK_TUNNEL_URL="https://$My_Domain_Or_Subdomain/" -e WEBHOOK_URL="https://$My_Domain_Or_Subdomain/" -v ~/.n8n:/root/.n8n -v /home/$USER/n8n-local-files:/files -v n8n_data:/home/node/.n8n n8nio/n8n:latest
sudo apt install nginx -y
sudo echo -e "server {\n    listen 80;\n    server_name $My_Domain_Or_Subdomain;\n\n    location / {\n        proxy_pass http://localhost:5678;\n        proxy_http_version 1.1;\n        chunked_transfer_encoding off;\n        proxy_buffering off;\n        proxy_cache off;\n        proxy_set_header Upgrade \$http_upgrade;\n        proxy_set_header Connection \"upgrade\";\n    }\n}" | sudo tee -a /etc/nginx/sites-available/n8n.conf > /dev/null
sudo ln -s /etc/nginx/sites-available/n8n.conf /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
sudo apt install certbot python3-certbot-nginx -y
sudo certbot --nginx -d $My_Domain_Or_Subdomain
