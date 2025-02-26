#!/bin/bash

echo -e "\n\n********************************************************************\n********************************************************************\n********************** JJ n8n update script ************************\n********************************************************************\n*********** https://github.com/Blakkos/n8n-cloud-aws ***************\n********************************************************************\n********************************************************************\n\n\n"

# Getting the current datetime and creating the backup folder with the timestamp.
my_current_date=$(date +"%d%b%Y_%H%M%S%Z")
mkdir ~/n8n_bk_$my_current_date

# Asking the user for info.
read -p "Enter the name of your n8n container (You can use sudo docker ps to find out.): " My_n8n_container_name
read -p "Enter the name of the docker volume mapped to the /home/node/.n8n folder located inside the container (/!\ IMPORTANT /!\ If you do not have that, please cancel this process with Ctrl+C): " My_n8n_volume
read -p "Enter your domain or subdomain name (Example:my-n8n.ddns.net): " My_Domain_Or_Subdomain
echo -e "********************************************************************\n********************************************************************\n*******************n8n backup process started...********************\n********************************************************************\n********************************************************************\n"

# Starting the backup process. everything will be saved in a backup folder called n8n_bk_DDMMMYYYY_hhmmssTZ in the user home directory.
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
echo "Backing up /home/node/.n8n folder..."
sudo docker cp n8n:/home/node/.n8n/ ~/n8n_bk_$my_current_date/.n8n_bk
echo "/home/node/.n8n folder is backed up!"
echo -e "********************************************************************\n********************************************************************\n****************** n8n backup process ended! ***********************\n********************************************************************\n********************************************************************\n"

# Stopping the container, pulling the latest version of n8n and restarting the container.
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

# Fin.
echo -e "\n\n\n\n********************************************************************\n********************************************************************\n********************** JJ n8n update script ************************\n********************************************************************\n*********** https://github.com/Blakkos/n8n-cloud-aws ***************\n********************************************************************\n********************************************************************\n******************* n8n update process ended! **********************\n********************************************************************\n********************************************************************\n\nGo to https://$My_Domain_Or_Subdomain/ to access your n8n instance.\n\n\n"
