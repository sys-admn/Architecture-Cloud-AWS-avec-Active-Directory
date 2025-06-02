# AWS Windows Active Directory Infrastructure with Terraform

This Terraform project deploys a comprehensive Windows Active Directory infrastructure on AWS, including SQL Server RDS, FSx for Windows File Server, and supporting components.

## Architecture Overview

The infrastructure includes the following components:

- **VPC and Networking**: Custom VPC with public and private subnets, NAT Gateway, and VPC endpoints
- **AWS Managed Microsoft AD**: Managed Active Directory service
- **FSx for Windows File Server**: Windows file share integrated with Active Directory
- **RDS SQL Server**: SQL Server database with Active Directory integration
- **EC2 Instances**: Windows Server instances joined to the domain and a Windows bastion host
- **Route53 Resolver**: DNS resolution between VPC and Active Directory
- **Security Groups**: Properly configured security groups for all components
- **IAM Roles**: Least privilege IAM roles for EC2 and RDS services

## Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform v1.0.0 or newer
- An AWS account with permissions to create all required resources

## Usage

### Directory Structure

```
terraform-aws-architecture-v2/
├── modules/                    # Reusable modules
│   ├── compute/                # EC2 instances
│   ├── identity/               # IAM and Managed AD
│   ├── networking/             # VPC, subnets, security groups
│   ├── route53_resolver_rule/  # Route53 resolver rules
│   └── storage/                # FSx and RDS
├── environments/               # Environment-specific configurations
│   ├── dev/                    # Development environment
│   └── prod/                   # Production environment
├── main.tf                     # Root module
├── variables.tf                # Input variables
└── outputs.tf                  # Output values
```

### Deployment Instructions

1. See readme file on environments/dev
   ```
2. cd environments/dev
   ```

## Configuration Notes

### SQL Server RDS Configuration

- SQL Server version 15.00.4236.7.v1 (SQL Server 2019) is used
- Only "error" and "agent" log types are supported for CloudWatch logs export
- Audit logs are not supported in this SQL Server version
- S3 import is not supported for SQL Server RDS

### Security Considerations

- All passwords in terraform.tfvars should be changed for production use
- EC2 key pairs should be created before deployment
- Consider enabling deletion protection for production RDS instances
- Review and adjust security group rules as needed

## Connecting to Resources

### Windows Bastion Host

Connect directly to the Windows bastion host using RDP:

1. Retrieve the public IP of the bastion host from the AWS Console or using:
   ```
   terraform output bastion_public_ip
   ```

2. Use an RDP client to connect to this IP using the Administrator credentials
   - Username: Administrator
   - Password: Retrieve using AWS Systems Manager Parameter Store or by decrypting the Windows password using your key pair

### Accessing Private Windows Servers

From the Windows bastion host, you can:

1. Use Remote Desktop Connection to connect to private Windows servers using their private IP addresses
2. Use SQL Server Management Studio to connect to the RDS SQL Server instance
3. Access the FSx file shares using File Explorer

### Alternative Access Methods

You can also use AWS Systems Manager for secure, bastion-free access:

1. **Session Manager**: Connect to Windows instances without opening RDP ports
   ```
   aws ssm start-session --target i-instanceid
   ```

2. **Fleet Manager**: Use the AWS Console for GUI-based management of Windows servers
   - Remote Desktop directly from the browser
   - File system and registry management
   - Windows service control

## Troubleshooting

Common issues and their solutions:

1. **Parameter Group Issues**: If you encounter errors with parameter groups, ensure you're using parameters supported by your SQL Server version.

2. **IAM Role Policies**: If you see errors about malformed policies, check that all policies have valid resources defined.

3. **S3 Bucket Lifecycle Rules**: Ensure lifecycle rules include a filter block with prefix attribute.

4. **RDP Connection Issues**: If you can't connect to the Windows bastion:
   - Verify the security group allows RDP (port 3389) from your IP
   - Check that the instance has a public IP assigned
   - Ensure you're using the correct key pair for password decryption

## Maintenance

- Regular updates to the RDS instance should be scheduled during maintenance windows
- FSx backups are configured but should be monitored
- Consider implementing additional monitoring and alerting

## License

This project is licensed under the MIT License - see the LICENSE file for details.