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

In `main.tf`, we have the following items configured:

- Our provider - in this case, AWS, because we really like building cloud infrastructure on AWS
  - The region we're building the infrastructure in - `us-east-1` in this case
  - The location of our AWS credentials file
  - The profile in the AWS credentials file to use
    - This allows Terraform to build our infrastructure

- The S3 bucket for our Terraform remote state file
  - The bucket being used in this case is `rearc-project-tfstate`
  - We're calling our state file `quest.json`
  - This bucket is located in the `us-east-1` region

- A resource that creates an AWS instance with the following properties:
  - Name `RearcServerInstance` (so we know what instance this is when we look in the AWS console)
  - AMI `ami-0ea00bb70e6d7d222` (The image we're building the instance from)
  - Instance type `t2.micro` (because the AWS free tier is awesome)
