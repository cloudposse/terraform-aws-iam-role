module "label" {
  source     = "git::https://github.com/cloudposse/terraform-terraform-label.git?ref=tags/0.4.0"
  attributes = var.attributes
  delimiter  = var.delimiter
  name       = var.name
  namespace  = var.namespace
  stage      = var.stage
  tags       = var.tags
  enabled    = var.enabled
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    dynamic "principals" {
      for_each = var.principals
      content {
        type = principals.key
        identifiers = principals.value
      }
    }
  }
}

resource "aws_iam_role" "default" {
  count                = var.enabled == "true" ? 1 : 0
  name                 = var.use_fullname == "true" ? module.label.id : module.label.name
  assume_role_policy   = data.aws_iam_policy_document.assume_role.json
  description          = var.role_description
  max_session_duration = var.max_session_duration
}

module "aggregated_policy" {
  source           = "git::https://github.com/cloudposse/terraform-aws-iam-policy-document-aggregator.git?ref=tags/0.2.0"
  source_documents = var.policy_documents
}

resource "aws_iam_policy" "default" {
  count       = var.enabled == "true" && var.policy_document_count > 0 ? 1 : 0
  name        = module.label.id
  description = var.policy_description
  policy      = module.aggregated_policy.result_document
}

resource "aws_iam_role_policy_attachment" "default" {
  count      = var.enabled == "true" && var.policy_document_count > 0 ? 1 : 0
  role       = aws_iam_role.default[0].name
  policy_arn = aws_iam_policy.default[0].arn
}
