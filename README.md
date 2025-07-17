# AppStream 2.0 Terraform Module

## Description
This module provisions and manages AWS AppStream 2.0 resources, including fleets, stacks, image builders, directory configuration, and all required networking and security group settings. It is designed for easy integration into your Terraform projects.

## Goal
- Automate the deployment of AWS AppStream 2.0 environments.
- Provide a reusable, configurable, and secure module for enterprise and development use cases.

## Architecture
- **AppStream Fleet**: Manages streaming instances for users.
- **AppStream Stack**: User access and application assignment.
- **Image Builder**: Custom image creation for AppStream.
- **Directory Config**: Integrates with Active Directory.
- **Security Group**: Allows required AppStream ports and internet access.

```
+-------------------+
|  Directory Config |
+-------------------+
         |
+-------------------+      +-------------------+
|   Image Builder   |<---->|   Security Group  |
+-------------------+      +-------------------+
         |
+-------------------+
|      Fleet        |
+-------------------+
         |
+-------------------+
|      Stack        |
+-------------------+
```

## Benefits
- Rapid, repeatable AppStream 2.0 deployments
- Secure by default (ports, internet access, IAM)
- Easily customizable for different environments
- Supports integration with Active Directory

## Usage
```hcl
module "appstream" {
  source = "./modules/appstream"

  vpc_id = "vpc-xxxxxxx"
  fleet_subnet_ids = ["subnet-xxxxxx"]
  image_builder_subnet_ids = ["subnet-xxxxxx"]
  # ...other variables as needed...
}
```

## Input Variables
- `fleet_name`, `instance_type`, `image_name`, `fleet_type`, `desired_instances`, `enable_default_internet_access`
- `stack_name`
- `image_builder_name`, `image_builder_instance_type`, `image_builder_image_name`, `image_builder_enable_default_internet_access`, `image_builder_description`, `image_builder_display_name`, `image_builder_subnet_ids`, `image_builder_security_group_ids`
- `directory_name`, `organizational_unit_distinguished_names`, `service_account_name`, `service_account_password`
- `vpc_id`, `fleet_subnet_ids`

(See `variables.tf` for full list and defaults.)

## Outputs
- `fleet_id`: ID of the AppStream fleet
- `stack_id`: ID of the AppStream stack
- `image_builder_id`: ID of the AppStream image builder
- `directory_config_id`: ID of the AppStream directory config

## Change Log
- **2025-06-04**: Initial version with fleet, stack, image builder, directory config, and security group support.

---
For more details, see the source files and comments in this module.
