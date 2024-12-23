locals {
  env = {
    default = {
      account_id    = "211125661413"
      region        = "eu-west-1"
      global_region = "us-east-1"
      project_name  = "venus"
      role_arn      = "arn:aws:iam::211125661413:role/OrganizationAccountAccessRole"
    }
    dev = {
    }
    prod = {
    }
  }
  environmentvars = contains(keys(local.env), terraform.workspace) ? terraform.workspace : "default"
  workspace       = merge(local.env["default"], local.env[local.environmentvars])
}
