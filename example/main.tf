data "aws_iam_policy_document" "resource_full_access" {
  statement {
    sid       = "FullAccess"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "sqs:GetQueueUrl",
    ]
  }
}

data "aws_iam_policy_document" "base" {
  statement {
    sid = "BaseAccess"

    actions = [
      "sqs:ListQueues",
    ]

    resources = ["*"]
    effect    = "Allow"
  }
}

module "role" {
  source = "../"

  enabled            = "true"
  namespace          = "cp"
  stage              = "test"
  name               = "app"
  policy_description = "sqs test"
  role_description   = "allows access to sqs to list queues and get url"

  principals = { "Service" = ["ec2.amazonaws.com"] }

  policy_documents = [
    "${data.aws_iam_policy_document.resource_full_access.json}",
    "${data.aws_iam_policy_document.base.json}",
  ]
}
