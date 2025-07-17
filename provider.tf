terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  # Optionally, you can add profile or other authentication methods here
  # profile = "your-aws-profile"
}

variable "aws_region" {
  description = "AWS region to deploy resources in."
  type        = string
  default     = "ap-south-1"
}

