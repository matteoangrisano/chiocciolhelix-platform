terraform {
  backend "s3" {
    bucket = "211125661413-terraform-backends-venus"
    key    = "terraform/infrastructure"
    region = "eu-west-1"
    assume_role = {
      role_arn     = "arn:aws:iam::211125661413:role/OrganizationAccountAccessRole"
      session_name = "devops"
    }
  }
}

provider "aws" {
  region = local.workspace["region"]
  assume_role {
    role_arn     = local.workspace["role_arn"]
    session_name = "devops"
  }
}

provider "aws" {
  alias  = "global"
  region = local.workspace["global_region"]
  assume_role {
    role_arn     = local.workspace["role_arn"]
    session_name = "devops"
  }
}
