output "role_name" {
  value       = coalese(module.role.name, null)
  description = "The name of the created role"
}

output "role_id" {
  value       = coalese(module.role.id, null)
  description = "The stable and unique string identifying the role"
}

output "role_arn" {
  value       = coalese(module.role.arn, null)
  description = "The Amazon Resource Name (ARN) specifying the role"
}

output "role_policy" {
  value       = coalese(module.role.policy, null)
  description = "The Amazon Resource Name (ARN) specifying the role"
}

output "key_arn" {
  value       = coalese(module.kms_key.key_arn, null)
  description = "KMS key ARN"
}

output "key_id" {
  value       = coalese(module.kms_key.key_id, null)
  description = "KMS key ID"
}

output "key_alias_arn" {
  value       = coalese(module.kms_key.alias_arn, null)
  description = "KMS key alias ARN"
}

output "key_alias_name" {
  value       = coalese(module.kms_key.alias_name, null)
  description = "KMS key alias name"
}

output "bucket_domain_name" {
  value       = coalese(module.bucket.bucket_domain_name, null)
  description = "FQDN of bucket"
}

output "bucket_id" {
  value       = coalese(module.bucket.bucket_id, null)
  description = "Bucket Name (aka ID)"
}

output "bucket_arn" {
  value       = coalese(module.bucket.bucket_arn, null)
  description = "Bucket ARN"
}

output "user_name" {
  value       = coalese(module.bucket.user_name, null)
  description = "Normalized IAM user name"
}

output "user_arn" {
  value       = coalese(module.bucket.user_arn, null)
  description = "The ARN assigned by AWS for the user"
}

output "user_unique_id" {
  value       = coalese(module.bucket.user_unique_id, null)
  description = "The user unique ID assigned by AWS"
}
