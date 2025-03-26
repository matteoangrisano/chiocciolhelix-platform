resource "aws_cognito_user_pool" "users" {
  name                     = "${local.workspace["project_name"]}-${terraform.workspace}-users"
  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]

  admin_create_user_config {
    allow_admin_create_user_only = false
  }

  verification_message_template {
    default_email_option = "CONFIRM_WITH_LINK"
    email_subject        = "Account registrato con successo"
    email_message        = "Grazie per la registrazione. Il tuo account è in attesa di approvazione da parte dell'amministratore. {####}"
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

  password_policy {
    minimum_length                   = 8
    require_lowercase                = true
    require_numbers                  = true
    require_symbols                  = true
    require_uppercase                = true
    temporary_password_validity_days = 7
  }

  mfa_configuration = "OFF"
}

resource "aws_cognito_user_pool_client" "users" {
  name         = "${local.workspace["project_name"]}-${terraform.workspace}-users"
  user_pool_id = aws_cognito_user_pool.users.id

  # Abilita l'inclusione dei gruppi nei token ID e Access
  read_attributes  = ["email", "email_verified"]
  write_attributes = ["email"]
}

# Definizione del gruppo admin
resource "aws_cognito_user_group" "admin_group" {
  name         = "admin"
  user_pool_id = aws_cognito_user_pool.users.id
  description  = "Administrators group with access to advanced features"
  precedence   = 0 # Priority highest
}
