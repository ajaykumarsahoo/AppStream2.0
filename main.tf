# This Terraform configuration sets up an AWS AppStream 2.0 environment
# with a fleet, stack, and optionally an image builder. It uses variables
# to customize the setup, including fleet type, instance types, and image names.
# The configuration also includes tags for resource management.
# The fleet can be configured for either single-session or multi-session usage,
# It supports internet access settings.
#--------------------------------------------------------------------------
module "appstream" {
  source = "./modules/appstream"

  # Required variables (replace with your values)
  fleet_name          = "example-fleet"
  appstream_image     = "Amazon-AppStream2-Sample-Image-06-17-2024"
  image_builder_name = "example-image-builder"
  image_name         = "AppStream-WinServer2019-05-30-2025"
  stack_name          = "example-stack"
  session_type        = "multi_session"
  desired_sessions    = 2
  enable_default_internet_access = "true"
}