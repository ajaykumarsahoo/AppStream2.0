module "appstream" {
  source = "./modules/appstream"

  # Required variables (replace with your values)
  fleet_name        = "example-fleet"
  instance_type     = "stream.standard.small"
  #image_name        = "AppStream-WinServer2019-05-30-2025"
  stack_name        = "example-stack"
}