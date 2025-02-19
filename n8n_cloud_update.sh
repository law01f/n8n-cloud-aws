#!/bin/bash
my_current_date=$(date +"%d%b%Y_%H%M%S%Z")
mkdir ~/n8n_bk_$my_current_date
read -p "Enter the name of your n8n container (You can use sudo docker ps to find out.): " My_n8n_container_name
read -p "Enter the name of the docker volume mapped to the /home/node/.n8n floder located inside the container (/!\ IMPORTANT /!\ If you do not have that, please cancel this process with Ctrl+C): " My_n8n_volume
read -p "Enter your domain or subdomain name (Example:my-n8n.ddns.net): " My_Domain_Or_Subdomain
echo -e "********************************************************************\n********************************************************************\n*******************n8n backup process started...********************\n********************************************************************\n********************************************************************\n"
echo "Backing up all workflows..."
sudo docker exec -u node -it $My_n8n_container_name n8n export:workflow --all --output=pre-exported-workflows.json
sudo docker cp $My_n8n_container_name:/home/node/pre-exported-workflows.json ~/n8n_bk_$my_current_date/exported-workflows.json
echo "All workflows are backed up!"
echo "Backing up all credentials..."
sudo docker exec -u node -it $My_n8n_container_name n8n export:credentials --all --output=pre-exported-credentials.json
sudo docker cp $My_n8n_container_name:/home/node/pre-exported-credentials.json ~/n8n_bk_$my_current_date/exported-credentials.json
echo "All credentials are backed up!"
echo "Backing up config file..."
sudo docker cp n8n:/home/node/.n8n/config ~/n8n_bk_$my_current_date/config_n8n_bk
echo "Config file is backed up!"
echo -e "********************************************************************\n********************************************************************\n****************** n8n backup process ended! ***********************\n********************************************************************\n********************************************************************\n"
echo -e "********************************************************************\n********************************************************************\n****************** n8n update process started... *******************\n********************************************************************\n********************************************************************\n"
sudo docker stop $My_n8n_container_name
echo "n8n container has been stopped!"
sudo docker rm $My_n8n_container_name
echo "n8n container has been removed!"
echo "Pulling the latest n8n image..."
sudo docker pull n8nio/n8n:latest
echo "The latest n8n image has been pulled!"
echo "Now starting updated n8n container..."
sudo docker run -d --restart unless-stopped -it --name n8n -p 5678:5678 -e N8N_HOST="$My_Domain_Or_Subdomain" -e WEBHOOK_TUNNEL_URL="https://$My_Domain_Or_Subdomain/" -e WEBHOOK_URL="https://$My_Domain_Or_Subdomain/" -v ~/.n8n:/root/.n8n -v ~/n8n-local-files:/files -v $My_n8n_volume:/home/node/.n8n n8nio/n8n:latest
echo -e "********************************************************************\n********************************************************************\n****************** n8n update process ended!... ********************
\n********************************************************************\n********************************************************************\n"
