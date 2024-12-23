resource "aws_cloudformation_stack" "my-terraform-output" {
  name = "${var.project_name}-${var.stage}-output"

  template_body = templatefile("${path.module}/template.tpl", {
    resources : var.resources,
    stage : var.stage,
    project_name : var.project_name
  })
}
