# Main resources for AppStream 2.0
# This module creates an AppStream fleet, stack, and image builder with enhanced user settings.
#--------------------------------------------------------------------------

#Security Group for AppStream:
resource "aws_security_group" "appstream" {
  name        = "appstream-sg"
  description = "Security group for AppStream resources"
  vpc_id      = var.vpc_id != "" ? var.vpc_id : data.aws_vpc.default.id

  # Allow all inbound traffic
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all inbound traffic"
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = local.fleet_tags
}
#-------------------------------------------------------------------------
resource "aws_appstream_fleet" "this" {
  name                         = var.fleet_name
  display_name                 = "AppStream 2.0 Fleet"
  compute_capacity {
    # Use desired_sessions for multi-session, desired_instances for single-session
    desired_instances          = var.session_type == "single_session" ? var.desired_instances : null
    desired_sessions           = var.session_type == "multi_session" ? var.desired_sessions : null
  }
  instance_type                = var.instance_type
  image_name                   = var.appstream_image != "" ? var.appstream_image : local.appstream_win_server_2019_image
  fleet_type                   = var.fleet_type
  stream_view                  = var.stream_view
  max_user_duration_in_seconds = var.max_user_duration_in_seconds
  idle_disconnect_timeout_in_seconds = var.idle_disconnect_timeout_in_seconds
  max_sessions_per_instance    = var.session_type == "multi_session" ? var.max_sessions_per_instance : 0
  enable_default_internet_access = var.enable_default_internet_access
  vpc_config {
    subnet_ids                 = [data.aws_subnet.supported_az_a.id, data.aws_subnet.supported_az_b.id]
    security_group_ids         = [aws_security_group.appstream.id]
  }
  tags                        = local.fleet_tags
  lifecycle {
    ignore_changes             = [compute_capacity]
  }
}
#-------------------------------------------------------------------------
# AppStream Stack
# This resource defines the stack for the AppStream fleet, including user settings and streaming experience settings
#-------------------------------------------------------------------------
resource "aws_appstream_stack" "this" {
  name        = var.stack_name
  display_name = "AppStream 2.0 Stack"
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
    action = "PRINTING_TO_LOCAL_DEVICE"
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
#--------------------------------------------------------------------------
#Image Builder for AppStream:
# This resource creates an AppStream image builder for creating custom images
#--------------------------------------------------------------------------
resource "aws_appstream_image_builder" "this" {
  name                = var.image_builder_name
  instance_type       = var.image_builder_instance_type
  image_name          = var.image_name != "" ? var.image_name : local.appstream_win_server_2019_image
  enable_default_internet_access = var.image_builder_enable_default_internet_access
  description         = var.image_builder_description
  display_name        = var.image_builder_display_name
  vpc_config {
    subnet_ids         = [data.aws_subnet.supported_az_a.id] # Use only a single supported subnet for image builder
    security_group_ids = [aws_security_group.appstream.id]
  }
  tags = local.fleet_tags
  depends_on = [aws_iam_role.appstream_role] 
}

#--------------------------------------------------------------------------
#Fleet-Stack Association:
# This resource associates the AppStream fleet with the stack created above
#--------------------------------------------------------------------------
resource "aws_appstream_fleet_stack_association" "this" {
  fleet_name = aws_appstream_fleet.this.name
  stack_name = aws_appstream_stack.this.name
  depends_on = [aws_appstream_fleet.this, aws_appstream_stack.this]
}

#--------------------------------------------------------------------------#
# User Pool and User Association
# This resource creates a user pool for the AppStream stack and associates it with the stack
#--------------------------------------------------------------------------
resource "aws_appstream_user" "this" {
  authentication_type = "USERPOOL"
  user_name           = "ajkumar.brm@gmail.com"
  first_name          = "Ajay"
  last_name           = "Kumar"
  enabled             = true
}


resource "aws_appstream_user_stack_association" "this" {
  stack_name           = aws_appstream_stack.this.name
  user_name            = aws_appstream_user.this.user_name
  authentication_type  = "USERPOOL"
  depends_on = [ aws_appstream_stack.this ]
}

#--------------------------------------------------------------------------