resource "aws_cognito_user_pool" "users" {
  name                     = "${local.workspace["project_name"]}-${terraform.workspace}-users"
  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]

  admin_create_user_config {
    allow_admin_create_user_only = false
  }

  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
    email_subject        = "Codice di verifica per ChiocciolHelix"
    email_message        = "Il tuo codice di verifica è: {####}"
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "given_name"
    required                 = false
    string_attribute_constraints {
      min_length = 1
      max_length = 255
    }
  }

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "family_name"
    required                 = false
    string_attribute_constraints {
      min_length = 1
      max_length = 255
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

# Configura un dominio per il pool utenti
resource "aws_cognito_user_pool_domain" "main" {
  domain       = "${local.workspace["project_name"]}-${terraform.workspace}-auth"
  user_pool_id = aws_cognito_user_pool.users.id
}

resource "aws_cognito_user_pool_client" "users" {
  name         = "${local.workspace["project_name"]}-${terraform.workspace}-users"
  user_pool_id = aws_cognito_user_pool.users.id

  # Abilita l'inclusione dei gruppi nei token ID e Access
  read_attributes  = ["email", "email_verified", "given_name", "family_name"]
  write_attributes = ["email", "given_name", "family_name"]
}

# Definizione del gruppo admin
resource "aws_cognito_user_group" "admin_group" {
  name         = "admin"
  user_pool_id = aws_cognito_user_pool.users.id
  description  = "Administrators group with access to advanced features"
  precedence   = 0 # Priority highest
}
