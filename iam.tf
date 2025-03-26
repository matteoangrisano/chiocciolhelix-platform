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

# AppSync

data "template_file" "appsync_assume_role_policy" {
  template = file("${path.module}/templates/appsync-assume-role-policy.tpl")
}

data "template_file" "appsync_role_policy" {
  template = file("${path.module}/templates/appsync-role-policy.tpl")
}

resource "aws_iam_role" "appsync_role" {
  name               = "${local.workspace["project_name"]}-${terraform.workspace}-appsync-role"
  assume_role_policy = data.template_file.appsync_assume_role_policy.rendered
}

resource "aws_iam_role_policy" "appsync_role_policy" {
  name   = "${local.workspace["project_name"]}-${terraform.workspace}-appsync-role-policy"
  role   = aws_iam_role.appsync_role.id
  policy = data.template_file.appsync_role_policy.rendered
}
