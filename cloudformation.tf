module "outputs" {
  source = "./modules/outputs"

  project_name = local.workspace["project_name"]
  stage        = terraform.workspace

  resources = [
    # cognito
    {
      name  = "CognitoUserPoolIdUsers"
      value = aws_cognito_user_pool.users.id
    },
    # iam
    {
      name  = "RoleLamba"
      value = aws_iam_role.lambda_role.arn
    },
    {
      name  = "RoleAppSync"
      value = aws_iam_role.appsync_role.arn
    },
    # dynamodb
    {
      name  = "TableUsers"
      value = aws_dynamodb_table.users.id
    },
    {
      name  = "TableProducts"
      value = aws_dynamodb_table.products.id
    },
    {
      name  = "TableOrders"
      value = aws_dynamodb_table.orders.id
    }
  ]
}
