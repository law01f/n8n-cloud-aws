#!/bin/bash
echo -e "********************************************************************\n********************************************************************\n********************** JJ n8n install script ***********************\n********************************************************************\n*********** https://github.com/Blakkos/n8n-cloud-aws ***************\n********************************************************************\n********************************************************************\n\n\n"
read -p "Enter your domain or subdomain name (Example:my-n8n.ddns.net): " My_Domain_Or_Subdomain

# System update
echo -e "\n\n********************************************************************\n************************ Updating system... ************************\n********************************************************************\n\n\n"
sudo apt update && sudo apt upgrade -y
echo -e "\n\n********************************************************************\n************************** System updated! *************************\n********************************************************************\n\n\n"

# Docker installation
echo -e "\n\n********************************************************************\n*********************** Installing Docker... ***********************\n********************************************************************\n\n\n"
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
echo -e "\n\n********************************************************************\n************************ Docker installed! *************************\n********************************************************************\n\n\n"

# Starting the n8n instance with a docker volume called n8n_data pointing to the /home/node/.n8n folder inside the container. This folder contains all the data needed for n8n to stay persistent between upgrades.
echo -e "\n\n********************************************************************\n********************* Starting n8n instance... *********************\n********************************************************************\n\n\n"
sudo docker run -d --restart unless-stopped -it --name n8n -p 5678:5678 -e N8N_HOST="$My_Domain_Or_Subdomain" -e WEBHOOK_TUNNEL_URL="https://$My_Domain_Or_Subdomain/" -e WEBHOOK_URL="https://$My_Domain_Or_Subdomain/" -v ~/.n8n:/root/.n8n -v ~/n8n-local-files:/files -v n8n_data:/home/node/.n8n n8nio/n8n:latest
echo -e "\n\n********************************************************************\n*********************** n8n instance started! **********************\n********************************************************************\n\n\n"

# Installing nginx and Cerbot to allow SSL when connecting to the instance from anywhere.
echo -e "\n\n********************************************************************\n************************ Installing nginx... ***********************\n********************************************************************\n\n\n"
sudo apt install nginx -y
sudo echo -e "server {\n    listen 80;\n    server_name $My_Domain_Or_Subdomain;\n\n    location / {\n        proxy_pass http://localhost:5678;\n        proxy_http_version 1.1;\n        chunked_transfer_encoding off;\n        proxy_buffering off;\n        proxy_cache off;\n        proxy_set_header Upgrade \$http_upgrade;\n        proxy_set_header Connection \"upgrade\";\n    }\n}" | sudo tee -a /etc/nginx/sites-available/n8n.conf > /dev/null
sudo ln -s /etc/nginx/sites-available/n8n.conf /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
echo -e "\n\n********************************************************************\n************************** nginx installed! ************************\n********************************************************************\n\n\n"

echo -e "\n\n********************************************************************\n*********************** Installing Certbot... **********************\n********************************************************************\n\n\n"
sudo apt install certbot python3-certbot-nginx -y
sudo certbot --nginx -d $My_Domain_Or_Subdomain
echo -e "\n\n********************************************************************\n************************* Certbot installed! ***********************\n********************************************************************\n\n\n"

# Fin.
echo -e "\n\n\n\n********************************************************************\n********************************************************************\n********************** JJ n8n install script ***********************\n********************************************************************\n*********** https://github.com/Blakkos/n8n-cloud-aws ***************\n********************************************************************\n********************************************************************\n******************** n8n install process ended! ********************\n********************************************************************\n********************************************************************\n\nGo to https://$My_Domain_Or_Subdomain/ to access your n8n instance.\n\n\n"
