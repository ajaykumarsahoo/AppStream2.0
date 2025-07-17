variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

variable "fleet_name" {
  description = "Name of the AppStream fleet."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for the fleet."
  type        = string
}

variable "image_name" {
  description = "AppStream image name. If not set, uses the latest Win Server 2019 image from registry."
  type        = string
  default     = ""
}

variable "fleet_type" {
  description = "Fleet type (ON_DEMAND or ALWAYS_ON)."
  type        = string
  default     = "ON_DEMAND"
}

variable "desired_instances" {
  description = "Number of desired instances in the fleet."
  type        = number
  default     = 1
}

variable "enable_default_internet_access" {
  description = "Enable default internet access for the fleet."
  type        = bool
  default     = false
}

variable "stack_name" {
  description = "Name of the AppStream stack."
  type        = string
}

variable "image_builder_name" {
  description = "Name of the AppStream image builder."
  type        = string
  default     = "example-image-builder"
}

variable "image_builder_instance_type" {
  description = "EC2 instance type for the image builder."
  type        = string
  default     = "stream.standard.medium"
}

variable "image_builder_image_name" {
  description = "AppStream image name for the image builder."
  type        = string
  default     = "AppStream-Win-Server-2019-07-15-2021"
}

variable "image_builder_enable_default_internet_access" {
  description = "Enable default internet access for the image builder."
  type        = bool
  default     = false
}

variable "image_builder_description" {
  description = "Description for the image builder."
  type        = string
  default     = "AppStream image builder"
}

variable "image_builder_display_name" {
  description = "Display name for the image builder."
  type        = string
  default     = "AppStreamImageBuilder"
}

variable "image_builder_subnet_ids" {
  description = "Subnet IDs for the image builder VPC config. Defaults to public subnets in the default VPC."
  type        = list(string)
  default     = []
}

variable "image_builder_security_group_ids" {
  description = "Security group IDs for the image builder VPC config."
  type        = list(string)
  default     = []
}

variable "vpc_id" {
  description = "VPC ID for AppStream resources. Defaults to the default VPC."
  type        = string
  default     = ""
}

variable "fleet_subnet_ids" {
  description = "Subnet IDs for the AppStream fleet. Defaults to public subnets in the default VPC."
  type        = list(string)
  default     = []
}

variable "stack_description" {
  description = "Description for the AppStream stack."
  type        = string
  default     = "AppStream stack for streaming applications with enhanced user settings."
}

variable "streaming_experience_protocol" {
  description = "Preferred protocol for streaming experience settings (TCP or UDP)."
  type        = string
  default     = "TCP"
}
