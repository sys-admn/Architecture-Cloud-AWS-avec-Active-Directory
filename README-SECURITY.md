# Security Best Practices for AWS Terraform Projects

## Preventing Secret Exposure

This repository includes tools to help prevent accidental exposure of secrets to Git repositories. Follow these guidelines to keep your infrastructure secure.

## Git Pre-commit Hook

A pre-commit hook is provided to scan files for potential secrets before they are committed to Git.

### Setup Instructions

#### Windows:
```powershell
# Run from the repository root
.\setup-git-hooks.ps1
```

#### Linux/macOS:
```bash
# Run from the repository root
chmod +x setup-git-hooks.sh
./setup-git-hooks.sh
```

### What the Pre-commit Hook Checks For

The pre-commit hook scans for:
- AWS access and secret keys
- API keys and tokens
- Passwords and credentials
- Private key files
- Terraform variables with sensitive values
- .tfvars files that might contain secrets

### Bypassing the Hook (Use with Caution)

In rare cases where you need to bypass the check:
```bash
git commit --no-verify
```

## Additional Security Best Practices

### 1. Use Environment Variables or AWS Vault

Instead of hardcoding credentials in .tfvars files, use environment variables:

```bash
# Set environment variables
export TF_VAR_admin_password="YourSecurePassword"
export TF_VAR_rds_password="YourSecureRDSPassword"

# Then run Terraform commands
terraform plan
```

Or use AWS Vault for credential management.

### 2. Use AWS Secrets Manager or Parameter Store

For production environments, store sensitive values in AWS Secrets Manager or Parameter Store and retrieve them in your Terraform code:

```hcl
data "aws_secretsmanager_secret" "admin_password" {
  name = "dev/ad/admin_password"
}

data "aws_secretsmanager_secret_version" "admin_password" {
  secret_id = data.aws_secretsmanager_secret.admin_password.id
}

locals {
  admin_password = jsondecode(data.aws_secretsmanager_secret_version.admin_password.secret_string)["password"]
}
```

### 3. Use .gitignore Properly

Ensure your .gitignore file excludes:
- *.tfvars files (except example templates)
- *.tfstate files
- .terraform directories
- Private key files (*.pem, *.key)
- Any local credential files

### 4. Rotate Credentials Regularly

- Implement a process to regularly rotate all passwords and access keys
- Use IAM roles with temporary credentials where possible

### 5. Encrypt State Files

If using remote state (recommended), ensure state files are encrypted:

```hcl
terraform {
  backend "s3" {
    bucket = "terraform-state-bucket"
    key    = "path/to/state"
    region = "us-east-1"
    encrypt = true
  }
}
```

### 6. Use Terraform Vault Provider

Consider using HashiCorp Vault with Terraform for advanced secret management:

```hcl
provider "vault" {
  address = "https://vault.example.com:8200"
}

data "vault_generic_secret" "db_credentials" {
  path = "secret/database/credentials"
}

resource "aws_db_instance" "database" {
  # ...
  username = data.vault_generic_secret.db_credentials.data["username"]
  password = data.vault_generic_secret.db_credentials.data["password"]
}
```

## Reporting Security Issues

If you discover a security vulnerability in this project, please report it responsibly by [contacting the security team].