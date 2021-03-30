output "name" {
  value       = join("", aws_iam_role.default.*.name)
  description = "The name of the IAM role created"
}

output "id" {
  value       = join("", aws_iam_role.default.*.unique_id)
  description = "The stable and unique string identifying the role"
}

output "arn" {
  value       = join("", aws_iam_role.default.*.arn)
  description = "The Amazon Resource Name (ARN) specifying the role"
}

output "policy" {
  value       = join("", data.aws_iam_policy_document.default.*.json)
  description = "Role policy document in json format. Outputs always, independent of `enabled` variable"
}
