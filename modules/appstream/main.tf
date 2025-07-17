# Main resources for AppStream 2.0

resource "aws_appstream_fleet" "this" {
  name                = var.fleet_name
  instance_type       = var.instance_type
  image_name          = var.image_name != "" ? var.image_name : local.appstream_win_server_2019_image
  fleet_type          = var.fleet_type
  compute_capacity {
    desired_instances = var.desired_instances
  }
  enable_default_internet_access = var.enable_default_internet_access
  vpc_config {
    subnet_ids         = slice(data.aws_subnets.public.ids, 0, 2) # Uses two subnets, typically in two AZs
    security_group_ids = [aws_security_group.appstream.id]
  }
  tags = local.fleet_tags
  # Add more configuration as needed
}

resource "aws_appstream_stack" "this" {
  name        = var.stack_name
  description = var.stack_description
  
  storage_connectors {
    connector_type = "HOMEFOLDERS"
  }
  user_settings {
    action = "CLIPBOARD_COPY_FROM_LOCAL_DEVICE"
    permission = "ENABLED"
  }
  user_settings {
    action = "CLIPBOARD_COPY_TO_LOCAL_DEVICE"
    permission = "ENABLED"
  }
  user_settings {
    action = "FILE_UPLOAD"
    permission = "ENABLED"
  }
  user_settings {
    action = "FILE_DOWNLOAD"
    permission = "ENABLED"
  }
  user_settings {
    action = "PRINT_TO_LOCAL_DEVICE"
    permission = "ENABLED"
  }
 
  streaming_experience_settings {
    preferred_protocol = var.streaming_experience_protocol
  }
  application_settings {
    enabled = true
    settings_group = "SettingsGroup"
  }
 
  tags = local.fleet_tags
}

#Image Builder for AppStream:
resource "aws_appstream_image_builder" "this" {
  name                = var.image_builder_name
  instance_type       = var.image_builder_instance_type
  image_name          = var.image_name != "" ? var.image_name : local.appstream_win_server_2019_image
  enable_default_internet_access = var.image_builder_enable_default_internet_access
  description         = var.image_builder_description
  display_name        = var.image_builder_display_name
  vpc_config {
    subnet_ids         = slice(data.aws_subnets.public.ids, 0, 2) # Uses two subnets, typically in two AZs
    security_group_ids = [aws_security_group.appstream.id]
  }
  iam_role_arn = aws_iam_role.appstream_role.arn
  tags = local.fleet_tags
  # Add more configuration as needed
}

resource "aws_security_group" "appstream" {
  name        = "appstream-sg"
  description = "Security group for AppStream resources"
  vpc_id      = var.vpc_id != "" ? var.vpc_id : data.aws_vpc.default.id

  # Allow AppStream ports (3389 for RDP, 4172 for PCoIP, 443 for HTTPS)
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow RDP from anywhere (for demo, restrict in production)"
  }
  ingress {
    from_port   = 4172
    to_port     = 4172
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow PCoIP from anywhere (for demo, restrict in production)"
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTPS from anywhere"
  }
  # Allow all outbound traffic (internet access)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
  tags = local.fleet_tags
}

#Fleet-Stack Association:
resource "aws_appstream_fleet_stack_association" "this" {
  fleet_name = aws_appstream_fleet.this.name
  stack_name = aws_appstream_stack.this.name
  depends_on = [aws_appstream_fleet.this, aws_appstream_stack.this]
}
