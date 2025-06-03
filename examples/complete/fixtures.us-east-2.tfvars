region = "us-east-2"

namespace = "eg"

stage = "test"

name = "iam-role-test"

use_fullname = true

principals = {
  "AWS" : ["*"]
}

inline_policy_enabled = true

assume_role_conditions = {
  AWS = [
    {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = ["test-external-id"]
    }
  ]
}

assume_role_actions = {
  AWS = ["sts:AssumeRole", "sts:TagSession"]
}
