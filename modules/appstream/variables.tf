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
  default     = "stream.standard.small"
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

variable "desired_sessions" {
  description = "Desired number of user sessions for a multi-session fleet. Only used if fleet_type is ON_DEMAND."
  type        = number
  default     = 1
}

variable "desired_instances" {
  description = "Desired number of streaming instances for a single-session fleet. Only used if fleet_type is ALWAYS_ON."
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
  default     = ""
}

variable "image_builder_instance_type" {
  description = "EC2 instance type for the image builder."
  type        = string
  default     = "stream.standard.small"
}

variable "image_builder_enable_default_internet_access" {
  description = "Enable default internet access for the image builder."
  type        = bool
  default     = true
}

variable "image_builder_description" {
  description = "Description for the image builder."
  type        = string
  default     = "AppStream 2.0 image builder"
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

variable "session_type" {
  description = "Type of session for the fleet: 'single_session' or 'multi_session'."
  type        = string
  default     = ""
}

variable "appstream_image" {
  description = "AppStream image name for the fleet. If not set, uses the value from locals."
  type        = string
  default     = ""
}

variable "max_user_duration_in_seconds" {
  description = "Maximum duration (in seconds) a user can be connected to a streaming session."
  type        = number
  default     = 3600 # 1 hour
}

variable "idle_disconnect_timeout_in_seconds" {
  description = "Time (in seconds) after which a user is disconnected due to inactivity."
  type        = number
  default     = 900 # 15 minutes
}

variable "stream_view" {
  description = "AppStream 2.0 view displayed to users when streaming from the fleet. 'APP' shows only application windows, 'DESKTOP' shows the full OS desktop. Defaults to 'APP'."
  type        = string
  default     = "APP"
}

variable "max_sessions_per_instance" {
  description = "The maximum number of user sessions on an instance. Only applies to multi-session fleets."
  type        = number
  default     = 5
}
