module "outputs" {
  source = "./modules/outputs"

  project_name = local.workspace["project_name"]
  stage        = terraform.workspace

  resources = [
    # dynamodb
    {
      name  = "TableUsers"
      value = aws_dynamodb_table.users.id
    },
    {
      name  = "TableOperators"
      value = aws_dynamodb_table.operators.id
    },
    {
      name  = "TableServices"
      value = aws_dynamodb_table.services.id
    },
    {
      name  = "TableAppointments"
      value = aws_dynamodb_table.appointments.id
    }
  ]
}
