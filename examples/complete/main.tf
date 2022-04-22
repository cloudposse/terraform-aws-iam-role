locals {
  enabled = module.this.enabled
}

provider "aws" {
  region = var.region
}

module "kms_key" {
  source  = "cloudposse/kms-key/aws"
  version = "0.12.1"

  description             = "Test KMS key"
  deletion_window_in_days = 7
  enable_key_rotation     = false

  context = module.this.context
}

module "bucket" {
  source  = "cloudposse/s3-bucket/aws"
  version = "2.0.0"

  user_enabled                 = false
  versioning_enabled           = false
  force_destroy                = true
  allow_encrypted_uploads_only = true
  sse_algorithm                = "aws:kms"
  kms_master_key_arn           = module.kms_key.key_arn

  context = module.this.context
}

data "aws_iam_policy_document" "resource_full_access" {
  count = local.enabled ? 1 : 0

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
      "s3:AbortMultipartUpload"
    ]
  }
}

data "aws_iam_policy_document" "base" {
  count = local.enabled ? 1 : 0

  statement {
    sid    = "BaseAccess"
    effect = "Allow"

    actions = [
      "s3:ListBucket",
      "s3:ListBucketVersions"
    ]

    resources = [
      module.bucket.bucket_arn
    ]
  }
}

module "role" {
  source = "../.."

  principals   = var.principals
  use_fullname = var.use_fullname

  policy_documents = [
    join("", data.aws_iam_policy_document.resource_full_access.*.json),
    join("", data.aws_iam_policy_document.base.*.json),
  ]

  policy_document_count = 2
  policy_description    = "Test IAM policy"
  role_description      = "Test IAM role"

  context = module.this.context
}
