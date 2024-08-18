# EC2 Provisioning and Cost Estimation
## Overview

1. Create a Golden AMI with Ubuntu 22.04 LTS and Nginx installed using Packer.
2. Provision an EC2 instance using Terraform with the created AMI.
3. Estimate the monthly cost of the provisioned EC2 instance using Infracost.

## Step 1: Create the Golden AMI
1. Clone the Repository

```
git clone https://github.com/your-repo/your-project.git
cd your-project
```
2. Build the AMI

  - Configure packer.json:

```
{
  "builders": [
    {
      "type": "amazon-ebs",
      "ami_name": "ubuntu-nginx-{{timestamp}}",
      "instance_type": "t2.micro",
      "region": "us-east-1",
      "source_ami": "ami-0c55b159cbfafe1f0",
      "ssh_username": "ubuntu"
    }
  ],
  "provisioners": [
    {
      "type": "shell",
      "inline": [
        "sudo apt-get update",
        "sudo apt-get install -y nginx"
      ]
    }
  ]
}
```
  - Run Packer:

```
packer build packer.json
```
  - Note the AMI ID from the output.

## Step 2: Provision the EC2 Instance with Terraform
1. Configure Terraform

  - Update main.tf with the AMI ID from Packer:
```
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-xxxxxxxx"
  instance_type = "t2.micro"

  tags = {
    Name = "MyEC2Instance"
  }
}
```
2. Deploy the EC2 Instance

  - Initialize Terraform:

```
terraform init
```
  - Apply the configuration:

```
terraform apply
```
## Step 3: Estimate Monthly Cost with Infracost
1. Authenticate with Infracost

```
infracost auth login
```
  - Follow the instructions to complete authentication.
2. Run Cost Estimation

  - Execute the cost estimation command:

```
infracost breakdown --path=.
```
  - Review the estimated monthly cost from the output.

<img width="821" alt="Screenshot 2024-08-18 at 1 18 45 PM" src="https://github.com/user-attachments/assets/a428fb52-303a-4f6d-94da-5cd67f00d2c7">
