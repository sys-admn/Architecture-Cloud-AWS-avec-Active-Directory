# Security Best Practices for AWS Terraform Projects

## Pre-commit Hook for Secret Detection

This repository includes a pre-commit hook that scans for potential secrets before they are committed to Git.

### What the Hook Detects

- Private key files (.pem, .key, .ppk, .p12, .pfx)
- Terraform variable files (.tfvars) that might contain secrets
- AWS access keys in file content
- Password assignments in code
- Private key content embedded in files

### Setup Instructions

The pre-commit hook is already installed in the repository. If you need to reinstall it:

1. Copy the pre-commit hook to Git's hooks directory:
   ```
   copy pre-commit .git\hooks\pre-commit
   ```

### Bypassing the Hook

In rare cases where you need to bypass the check (use with caution):
```
git commit --no-verify -m "Your commit message"
```

## Additional Security Best Practices

### 1. Use Environment Variables

Instead of hardcoding credentials in .tfvars files:

```powershell
# PowerShell
$env:TF_VAR_admin_password = "YourSecurePassword"
$env:TF_VAR_rds_password = "YourSecureRDSPassword"

# Then run Terraform commands
terraform plan
```

### 2. Use AWS Secrets Manager or Parameter Store

For production environments, store sensitive values in AWS Secrets Manager or Parameter Store.

### 3. Separate Configuration from Secrets

Use separate files for configuration and secrets:
- `terraform.tfvars` - Non-sensitive configuration
- `secrets.auto.tfvars` - Sensitive values (add to .gitignore)

### 4. Encrypt State Files

If using remote state, ensure state files are encrypted:

```hcl
terraform {
  backend "s3" {
    bucket  = "terraform-state-bucket"
    key     = "path/to/state"
    region  = "us-east-1"
    encrypt = true
  }
}
```

### 5. Rotate Credentials Regularly

Implement a process to regularly rotate all passwords and access keys.