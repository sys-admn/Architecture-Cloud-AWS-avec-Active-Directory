variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "force_destroy" {
  description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error"
  type        = bool
  default     = false
}

variable "enable_versioning" {
  description = "Enable versioning on the bucket"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "The AWS KMS key ID to use for object encryption"
  type        = string
  default     = null
}

variable "lifecycle_rules" {
  description = "List of lifecycle rules to configure"
  type        = any
  default     = []
}

variable "block_public_acls" {
  description = "Whether Amazon S3 should block public ACLs for this bucket"
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Whether Amazon S3 should block public bucket policies for this bucket"
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Whether Amazon S3 should ignore public ACLs for this bucket"
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket"
  type        = bool
  default     = true
}

variable "bucket_policy" {
  description = "A bucket policy in JSON format"
  type        = string
  default     = null
}

variable "create_rds_backup_folders" {
  description = "Whether to create folder structure for RDS backups"
  type        = bool
  default     = false
}

variable "rds_instance_identifiers" {
  description = "List of RDS instance identifiers for which to create backup folders"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}