module "kms_key" {
  source    = "git::https://github.com/rverma-nikiai/terraform-aws-kms-key.git?ref=master"
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
  source  = "git::https://github.com/rverma-nikiai/terraform-aws-s3-bucket.git?ref=master"
  enabled = "true"

  namespace = "cp"
  stage     = "prod"
  name      = "chamber"

  tags = {
    ManagedBy = "Terraform"
  }

  versioning_enabled = "false"
  user_enabled       = "false"

  sse_algorithm     = "aws:kms"
  kms_master_key_id = "${module.kms_key.key_id}"
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

    resources = ["${module.bucket.bucket_arn}"]
    effect    = "Allow"
  }
}

module "role" {
  source = "../"

  enabled   = "true"
  namespace = "cp"
  stage     = "prod"
  name      = "app"

  principals_arns = []

  policy_documents = [
    "${data.aws_iam_policy_document.resource_full_access.json}",
    "${data.aws_iam_policy_document.base.json}",
  ]
}
