module "kms_key" {
  source    = "git::https://github.com/cloudposse/terraform-aws-kms-key.git?ref=0.11/master"
  namespace = "cp"
  stage     = "prod"
  name      = "app"

  tags = {
    ManagedBy = "Terraform"
  }

  description             = "KMS key for Parameter Store"
  deletion_window_in_days = 10
  enable_key_rotation     = "true"
  alias                   = "alias/parameter_store_key"
}

module "bucket" {
  source  = "git::https://github.com/cloudposse/terraform-aws-s3-bucket.git?ref=0.11/master"
  enabled = "true"

  namespace = "cp"
  stage     = "prod"
  name      = "chamber"

  tags = {
    ManagedBy = "Terraform"
  }

  versioning_enabled = "false"
  user_enabled       = "false"

  sse_algorithm      = "aws:kms"
  kms_master_key_arn = module.kms_key.key_arn
}

data "aws_iam_policy_document" "resource_full_access" {
  statement {
    sid       = "FullAccess"
    effect    = "Allow"
    resources = ["${module.bucket.bucket_arn}/*"]

    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:GetBucketLocation",
      "s3:AbortMultipartUpload",
    ]
  }
}

data "aws_iam_policy_document" "base" {
  statement {
    sid = "BaseAccess"

    actions = [
      "s3:ListBucket",
      "s3:ListBucketVersions",
    ]

    # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
    # force an interpolation expression to be interpreted as a list by wrapping it
    # in an extra set of list brackets. That form was supported for compatibility in
    # v0.11, but is no longer supported in Terraform v0.12.
    #
    # If the expression in the following list itself returns a list, remove the
    # brackets to avoid interpretation as a list of lists. If the expression
    # returns a single list item then leave it as-is and remove this TODO comment.
    resources = [module.bucket.bucket_arn]
    effect    = "Allow"
  }
}

module "role" {
  source = "../"

  enabled   = "true"
  namespace = "cp"
  stage     = "prod"
  name      = "app"

  principals = {}

  policy_documents = [
    data.aws_iam_policy_document.resource_full_access.json,
    data.aws_iam_policy_document.base.json,
  ]
}

