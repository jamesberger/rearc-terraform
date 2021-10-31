# rearc-terraform
A repository for Terraform code for the Rearc project

This code allows Terraform to spin up the infrastructure we need to run the Rearc Quest app, which includes:
- An EC2 instance built from an AMI
 - The AMI was built from an Amazon Linux instance with the following items configured:
  - Docker, Nodejs and Git installed with yum
  - A cloned copy of the Rearc Quest repository at https://github.com/rearc/quest
  - A Docker image containing the Rearc Quest app
  - A Systemd unit file that calls a script that starts this Docker image on boot
    - The script is just one line - `sudo docker run -p 3000:3000 --env-file ./envs james/rearc-app`

When Terraform spins this EC2 instance up, the instance will accept traffic on port 22 for SSH access and port 3000 for web based acccess to the app.
