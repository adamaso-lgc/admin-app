locals {
    user_pool           = "${var.environment}-${var.name}-pool"
    user_pool_client    = "${var.environment}-${var.name}-client"
}

resource "aws_cognito_user_pool" "user_pool" {
  name                      = local.user_pool

  username_attributes       = ["email"]
  auto_verified_attributes  = ["email"]

  password_policy {
    minimum_length          = 8
  }

  email_configuration {
    email_sending_account   = "COGNITO_DEFAULT"
  }

  verification_message_template {
    default_email_option    = "CONFIRM_WITH_CODE"
    email_subject           = "Account Confirmation"
    email_message           = "Your confirmation code is {####}"
  }

}

resource "aws_cognito_user_pool_client" "client" {
  name                          = local.user_pool_client
    
  user_pool_id                  = aws_cognito_user_pool.user_pool.id
  generate_secret               = false
  refresh_token_validity        = 90
  prevent_user_existence_errors = "ENABLED"
  explicit_auth_flows           = [
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_ADMIN_USER_PASSWORD_AUTH"
  ]
  
}
