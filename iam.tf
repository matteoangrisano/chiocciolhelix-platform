
# Lambda

data "template_file" "lambda_assume_role_policy" {
  template = file("${path.module}/templates/lambda-assume-role-policy.tpl")
}

data "template_file" "lambda_role_policy" {
  template = file("${path.module}/templates/lambda-role-policy.tpl")
}

resource "aws_iam_role" "lambda_role" {
  name               = "${local.workspace["project_name"]}-${terraform.workspace}-lambda-role"
  assume_role_policy = data.template_file.lambda_assume_role_policy.rendered
}

resource "aws_iam_role_policy" "lambda_role_policy" {
  name   = "${local.workspace["project_name"]}-${terraform.workspace}-lambda-role-policy"
  role   = aws_iam_role.lambda_role.id
  policy = data.template_file.lambda_role_policy.rendered
}
