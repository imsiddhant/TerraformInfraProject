=========================================================================

# Terraform Infrastructure Project

**Automated Infrastructure Provisioning for a Multi-Tier Web Application**

## Description

This project automates the provisioning of all necessary infrastructure components on AWS for hosting a multi tier web application using Terraform. It includes setting up networking, compute resources, databases, and security groups to ensure a scalable, secure, and efficient environment.

## Table of Contents

1. [Getting Started](#getting-started)
2. [Prerequisites](#prerequisites)
3. [Project Structure](#project-structure)
4. [Infrastructure Components](#infrastructure-components)
   - [Networking Setup](#networking-setup)
   - [Compute Resources](#compute-resources)
   - [Database Configuration](#database-configuration)
   - [Security and Access Control](#security-and-access-control)
   - [Monitoring](#monitoring)
5. [Usage](#usage)
6. [Contributing](#contributing)
7. [License](#license)

## Getting Started

To get started with this project, clone the repository and follow the instructions below to set up your environment.

```bash
git clone https://github.com/imsiddhant/TerraformInfraProject.git
cd TerraformInfraProject
```

## Prerequisites

1. Terraform (recommended version 1.9.x or above)
2. An AWS account with appropriate permissions to create resources.
3. AWS CLI configured with your credentials.
4. You can attach following managed policies to the IAM User:
   - AmazonEC2FullAccess
   - AmazonRDSFullAccess
   - AmazonVPCFullAccess
   - CloudWatchFullAccess

## Project Structure

```
TerraformInfraProject/
│
├── module
   ├── Compute
      ├── app.sh
      ├── main.tf
      ├── outputs.tf
      ├── variables.tf
   ├── Database
      ├── main.tf
      ├── outputs.tf
      ├── variables.tf
   ├── Monitoring
      ├── main.tf
      ├── outputs.tf
      ├── variables.tf
   ├── Networking
      ├── main.tf
      ├── outputs.tf
      ├── variables.tf
├── main.tf
└── README.md
```

## Infrastructure Components

- Networking Setup
1. Create a Virtual Private Cloud (VPC) with public and private subnets.
2. Configure route tables and internet gateways for public subnet access.

- Compute Resources
1. Launch EC2 instances to host the web application.
2. Use Auto Scaling Groups to ensure high availability and scalability.
3. Utilize Elastic Load Balancing for distributing incoming traffic.

- Database Configuration
1. Set up a managed database service like Amazon RDS for storing application data.
2. Choose the appropriate database engine (e.g., MySQL, PostgreSQL) based on your application's requirements.

- Security and Access Control
1. Implement security groups to control inbound and outbound traffic to EC2 instances and databases.

- Monitoring
1. Set up an SNS topic with an email subscription for notifications.
2. Configure CloudWatch alarms to monitor the health of Compute and Database resources.

## Usage

1. Modify variables.tf to set your desired configurations.

2. Initialize Terraform:
```
bash
Copy code
terraform init
```

3. Plan the infrastructure deployment:
```
bash
Copy code
terraform plan
```

4. Apply the configuration to create resources:
```
bash
Copy code
terraform apply
```

5. To destroy the infrastructure when it's no longer needed:
```
bash
Copy code
terraform destroy
```

## Contributing
Contributions are welcome! Please open an issue or submit a pull request for any improvements or features you'd like to see.

=========================================================================