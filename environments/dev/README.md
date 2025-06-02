# Development Environment

This directory contains the Terraform configuration for the development environment of the Windows AD infrastructure.

## Components

- VPC with public and private subnets
- AWS Managed Microsoft AD
- FSx Windows File Server
- RDS SQL Server with AD integration
- EC2 Windows instances joined to the AD domain
- Windows Bastion host for secure access
- S3 bucket for RDS backups

## Usage

```bash
# Initialize Terraform
terraform init

# Plan the deployment
terraform plan -var-file="terraform.tfvars"

# Apply the configuration
terraform apply -var-file="terraform.tfvars"

# Destroy the environment when no longer needed
terraform destroy -var-file="terraform.tfvars"
```

## Important Notes

1. **Passwords**: The passwords in `terraform.tfvars` are placeholders. Replace them with secure passwords before deploying.

2. **Key Pairs**: Make sure the EC2 key pair (`windows-key-dev`) exists in your AWS account before deploying.

3. **S3 Bucket Names**: The S3 bucket name must be globally unique. The current configuration appends the environment name to the bucket name.

4. **AD Integration**: After deployment, you'll need to manually join the Windows EC2 instances to the AD domain.

## Connecting to Resources

### Windows Bastion Host

1. Retrieve the public IP of the Windows bastion host:
   ```bash
   terraform output bastion_public_ip
   ```

2. Connect using Remote Desktop Protocol (RDP):
   - Server: <bastion_public_ip>
   - Username: Administrator
   - Password: Retrieve using the AWS Console by selecting the instance and clicking "Connect" > "RDP client" > "Get password"

### Private Windows Servers

From the Windows bastion host, you can connect to private resources:

1. **Windows Servers**:
   - Open Remote Desktop Connection
   - Connect to the private IP of the Windows server
   - Use domain credentials: DEVCORP\Administrator

2. **RDS SQL Server**:
   - Open SQL Server Management Studio
   - Server: <rds_instance_endpoint>
   - Authentication: SQL Server Authentication or Windows Authentication (if configured)
   - Username: admin (or the username you specified)
   - Password: <your_password>

3. **FSx File Share**:
   - Open File Explorer
   - Navigate to: \\<fsx_dns_name>\share
   - Authenticate with domain credentials

## Using AWS Systems Manager (Alternative)

You can also use AWS Systems Manager to manage your Windows instances without using the bastion host:

1. In the AWS Console, go to Systems Manager > Fleet Manager
2. Select your Windows instance
3. Click "Node actions" > "Connect with Remote Desktop"
4. This provides browser-based RDP access without needing to open inbound ports

## Customization

To customize the deployment, modify the variables in `terraform.tfvars` or override them using command-line arguments:

```bash
terraform apply -var-file=terraform.tfvars -var="rds_instance_class=db.m5.xlarge"
```