# Self-Hosting n8n on AWS with SSL 

n8n is a very popular workflow automation platform that allows you to 


## Step 1: Create the Free Tier EC2 instance on AWS

## Step 2: Run my install script

1. **Download the script:**
   ```bash
   wget https://github.com/Blakkos/n8n-cloud/raw/refs/heads/main/n8n_cloud_install.sh


2. **Modify the execute rights on the file:**
   ```bash
   chmod +x n8n_cloud_install.sh


3. **Run the script:**
   ```bash
   ./n8n_cloud_install.sh


4. **Enter your domain or subdomain name. I have used a free dynamic DNS service for this test but you can use any other paid service. Once you've entered the domain or subdomain name, press Enter and the script will start running for a few minutes:**
   ![n8n-6-1](https://github.com/user-attachments/assets/f0a40a6a-76b9-43fa-a4a0-c0714ead2107)


5. **Enter a VALID email address. You will be prompted to do so in order to start the registration process for your SSL certificate.**
   ![n8n-7](https://github.com/user-attachments/assets/83b8cc10-a394-4188-baf7-6107bbe60863)


6. **You have to accept the terms and conditions to go to the next step.**
   ![n8n-8](https://github.com/user-attachments/assets/b8e33549-70e0-4db0-824e-8565338fc864)


7. **Answer this next question however you prefer.**
   
   ![n8n-9](https://github.com/user-attachments/assets/24b0f04b-b62a-4a65-bf50-72243ab1f900)


9. **If everything went well, you should see something simmilar to this:**
   ![n8n-10](https://github.com/user-attachments/assets/a16babfd-a65f-4a13-8754-d02952be324a)
