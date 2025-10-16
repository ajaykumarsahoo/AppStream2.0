module "appstream" {
  source = "./modules/appstream"

  # Required variables (replace with your values)
  fleet_name          = "example-fleet"
  appstream_image     = "Amazon-AppStream2-Sample-Image-06-17-2024"
  image_builder_name = "example-image-builder"
  #image_name         = "AppStream-WinServer2019-05-30-2025"
  stack_name          = "example-stack"
  session_type        = "multi_session"
  enable_default_internet_access = "true"
}