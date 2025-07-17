#locals
locals {
  fleet_tags = {
    Environment = var.environment
    Project     = "AppStream"
    CreatedBy   = "Terraform"
  }

  appstream_win_server_2019_image = data.aws_appstream_image.latest_win_server_2019.name
}
