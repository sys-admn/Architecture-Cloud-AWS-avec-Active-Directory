variable "name" {
  description = "The name of the security group"
  type        = string
}

variable "description" {
  description = "The description of the security group"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

variable "ingress_rules" {
  description = "List of ingress rules to create"
  type        = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}