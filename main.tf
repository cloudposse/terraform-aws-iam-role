data "aws_iam_policy_document" "assume_role" {
  count = length(keys(var.principals))

  statement {
    effect  = "Allow"
    actions = [var.assume_role_action]

    principals {
      type        = element(keys(var.principals), count.index)
      identifiers = var.principals[element(keys(var.principals), count.index)]
    }
  }
}

module "aggregated_assume_policy" {
  source           = "cloudposse/iam-policy-document-aggregator/aws"
  version          = "0.6.0"
  source_documents = data.aws_iam_policy_document.assume_role.*.json
}

resource "aws_iam_role" "default" {
  count                = module.this.enabled ? 1 : 0
  name                 = var.use_fullname ? module.this.id : module.this.name
  assume_role_policy   = module.aggregated_assume_policy.result_document
  description          = var.role_description
  max_session_duration = var.max_session_duration
  tags                 = module.this.tags
}

module "aggregated_policy" {
  source           = "cloudposse/iam-policy-document-aggregator/aws"
  version          = "0.6.0"
  source_documents = var.policy_documents
}

resource "aws_iam_policy" "default" {
  count       = module.this.enabled && var.policy_document_count > 0 ? 1 : 0
  name        = module.this.id
  description = var.policy_description
  policy      = module.aggregated_policy.result_document
}

resource "aws_iam_role_policy_attachment" "default" {
  count      = module.this.enabled && var.policy_document_count > 0 ? 1 : 0
  role       = join("", aws_iam_role.default.*.name)
  policy_arn = join("", aws_iam_policy.default.*.arn)
}
