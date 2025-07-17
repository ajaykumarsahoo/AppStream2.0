#Terraform Cloud backend
terraform {
  cloud {
    organization = "terraform-cloud-aj"

    workspaces {
      name = "CLI-Workspace"
    }
  }
}