generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
  terraform {
    cloud {

      organization = "ck0ne"
      hostname     = "app.terraform.io"

      workspaces {
        name = "${path_relative_to_include()}"
      }
    }
  }
  EOF
}
