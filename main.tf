module "appstream" {
  source = "./modules/appstream"

  # Required variables (replace with your values)
  fleet_name        = "example-fleet"
  instance_type     = "stream.standard.medium"
  image_name        = "AppStream-Win-Server-2019-07-15-2021"
  stack_name        = "example-stack"
}