output "role_name" {
  value       = one([module.role.name])
  description = "The name of the created role"
}

output "role_id" {
  value       = one([module.role.id])
  description = "The stable and unique string identifying the role"
}

output "role_arn" {
  value       = one([module.role.arn])
  description = "The Amazon Resource Name (ARN) specifying the role"
}

output "role_policy" {
  value       = one([module.role.policy])
  description = "The Amazon Resource Name (ARN) specifying the role"
}

output "key_arn" {
  value       = one([module.kms_key.key_arn])
  description = "KMS key ARN"
}

output "key_id" {
  value       = one([module.kms_key.key_id])
  description = "KMS key ID"
}

output "key_alias_arn" {
  value       = one([module.kms_key.alias_arn])
  description = "KMS key alias ARN"
}

output "key_alias_name" {
  value       = one([module.kms_key.alias_name])
  description = "KMS key alias name"
}

output "bucket_domain_name" {
  value       = one([module.bucket.bucket_domain_name])
  description = "FQDN of bucket"
}

output "bucket_id" {
  value       = one([module.bucket.bucket_id])
  description = "Bucket Name (aka ID)"
}

output "bucket_arn" {
  value       = one([module.bucket.bucket_arn])
  description = "Bucket ARN"
}

output "user_name" {
  value       = one([module.bucket.user_name])
  description = "Normalized IAM user name"
}

output "user_arn" {
  value       = one([module.bucket.user_arn])
}

output "user_unique_id" {
  value       = one([module.bucket.user_unique_id])
  description = "The user unique ID assigned by AWS"
}
