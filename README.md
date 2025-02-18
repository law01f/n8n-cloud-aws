# Self-Hosting n8n on AWS with SSL 

[n8n](https://n8n.io) is a very popular workflow automation platform that allows you to connect various services to automate processes using little to no code.
It can be used with their subscription model or self-hosted locally or in the cloud.
The benefit of having n8n self hosted comes not only from the fact that you don't have to pay the monthy fee but also that you won't be limited in the amount of concurent automations.

After trying various tutorials, I found a very good one from [futurminds' github](https://github.com/futurminds/n8n-self-hosting) and decided to create a script to try to make the installation process even easier.

These instructions were created for an AWS environment and require the use of a DNS or dynamic DNS service. Make sure you have access to both before going further.

## Step 1: Create the Free Tier EC2 instance on AWS

1. Go to your AWS account, then in the EC2 section, create a new virtual machine by clicking **Launch an instance**. Give it the name that you want. Select **Ubuntu** as the OS image. If you want it to be completely free, make sure to select anything **Free tier eligible**. I found that n8n runs very well on free tier configurations on AWS or Google Cloud.

   ![n8n-1](https://github.com/user-attachments/assets/ed753513-db72-4f61-abc0-2a4d76db7c8c)

2. For the **Instance type**, select **t2.micro** as it is Free tier eligible. For **Key pair**, create a new pair or use an existing one accordingly to your security guidelines or policies.

   ![n8n-2](https://github.com/user-attachments/assets/06600e61-c82b-4f60-aeee-c9c906053b50)

3. For **Network settings**, you can create a new security group ou use an existing one depending on your security guidelines or policies. The most important is that you **allow HTTP and HTTPS traffic** as this is how your n8n instance will be accessible. Allow also **SSH traffic** to access your instance using command line interface. (I recommand for added security change "Anywhere" to "My IP" in order to restrict who could access your instance using SSH. I also recommand that you disable SSH traffic to your instance once you are done with the installation steps.)**

   ![n8n-3](https://github.com/user-attachments/assets/87566f4c-ed36-4f14-bfc4-6aa0a65704ae)


4. For **Configure storage**, you can choose anything between 8 to 30 GB. In the example I have used 20GB. if you choose anything more than 30GB, your instance won't be considered Free tier eligible.

   ![n8n-4](https://github.com/user-attachments/assets/610f23c6-2364-42eb-bb77-a7faedd52a1d)

5. At the end your summary should look like this. Make sure you see that banner indicating that your instance is Free tier eligible and click **Launch instance** to create and start your instance.
   
   ![n8n-5](https://github.com/user-attachments/assets/29f9590d-31e0-4689-a893-a81ea1344732)

6. You should get a message telling you that your virtual machine has been created successfully. click on the instance ID and you will be back to the instance dashboard, select your new instance and click **Connect** to connect to the command line interface of your virtual machine. You will also find instructions to use SSH with the key you have created earlier.

     ![n8n-6](https://github.com/user-attachments/assets/698baf4e-3386-4213-9985-acbdbb572c9b)

Now that your brand new virtual machine has been created, you can go to the next step!

## Step 2: Run my install script
Before starting Step 2, you **need to have a valid domain or subdomain** that you can use and that you own. You can use a dynamic DNS service as I did for this tutorial. You need to select the public IP of your newly create instance and update the IP address that will be used fo the name resolution. Ok, now you can really go to the next step!

1. **Download the script:**
   ```bash
   wget https://github.com/Blakkos/n8n-cloud-aws/raw/refs/heads/main/n8n_cloud_install.sh
2. **Modify the execute rights on the file:**
   ```bash
   chmod +x n8n_cloud_install.sh
3. **Run the script:**
   ```bash
   ./n8n_cloud_install.sh
4. Enter your **domain or subdomain name**. I have used a free dynamic DNS service for this test but you can use any other paid service. Once you've entered the domain or subdomain name, press **Enter** and the script will start running for a few minutes:

   ![n8n-6-1](https://github.com/user-attachments/assets/f0a40a6a-76b9-43fa-a4a0-c0714ead2107)


5. Enter a **VALID email address**. You will be prompted to do so in order to start the registration process for your SSL certificate.

   ![n8n-7](https://github.com/user-attachments/assets/83b8cc10-a394-4188-baf7-6107bbe60863)


6. You have to **accept** the terms and conditions to go to the next step.

   ![n8n-8](https://github.com/user-attachments/assets/b8e33549-70e0-4db0-824e-8565338fc864)


7. Answer this next question however you prefer.
   
   ![n8n-9](https://github.com/user-attachments/assets/24b0f04b-b62a-4a65-bf50-72243ab1f900)


9. If everything went well, you should see something simmilar to this:

   ![n8n-10](https://github.com/user-attachments/assets/a16babfd-a65f-4a13-8754-d02952be324a)

**IN CASE OF ERROR:** If this last step gives you errors (as it did to me many times), you might have a DNS related issue. Sometimes it can take a few minutes or a few hours for the update of the IP address in your dynamic DNS service to take effect.
in that case, double check that you have entered the proper IP address and try later using this last command (replace the placeholder by your domain or subdomain name):
   ```bash
   sudo certbot --nginx -d MyPlaceholder-DomainOrSubdomain.replaceme.net
```

10. You can now open your browser and go to the URL of your n8n instance https://MyPlaceholder-DomainOrSubdomain.replaceme.net
   ![n8n-11](https://github.com/user-attachments/assets/35783028-11f0-4914-9bb5-785da10db09e)

    You can now enjoy your n8n instance!


    
**IN CASE OF ERROR:** Your instance should be accessible as soon as the script finished running. In some cases, I have noticed that the URL was not accessible and I had to reboot the instance for everything to work properly.
Use this to reboot your instance:
   ```bash
   sudo reboot
```
After rebooting, you should have access to your instance. Make sure the public ip address did not change. You can find it in the EC2 dashboard.
