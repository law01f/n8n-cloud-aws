# Self-Hosting n8n on AWS with SSL 

n8n is a very popular workflow automation platform that allows you to 


## Step 1: Create the Free Tier EC2 instance on AWS

1. **Go to your AWS account, then in the EC2 section, create a new  virtual machine by clicking "Launch an instance". Give it the name that you want. Select "Ubuntu" as the OS image. If you want it to be completely free, make sure to select anything Free tier eligible. I found that n8n runs very well on free tier configurations on AWS or Google Cloud.**

   ![n8n-1](https://github.com/user-attachments/assets/ed753513-db72-4f61-abc0-2a4d76db7c8c)

2. **For the instance type, select t2.micro as it is Free tier eligible. For "Key pair", create a new pair or use an existing one accordingly to your security guidelines or policies.**

   ![n8n-2](https://github.com/user-attachments/assets/06600e61-c82b-4f60-aeee-c9c906053b50)

3. **For "Network settings", You can create a new security group ou use an existing one depending on your security guidelines or policies. The most important is that you allow HTTP and HTTPS traffic as this is how your n8n instance will be accessible. Allow also SSH traffic to acess your instance using command line interface. (I recommand for added security change "Anywhere" to "My IP" in order to restrict who could access your instance using SSH. I also recommand that you disable SSH traffic to your instance once you are done with the installation steps.)**

   ![n8n-3](https://github.com/user-attachments/assets/87566f4c-ed36-4f14-bfc4-6aa0a65704ae)


4. **For "Configure storage", you can choose anything between 8 to 30 GB

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
