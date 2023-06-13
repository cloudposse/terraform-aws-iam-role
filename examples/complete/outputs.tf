output "role_name" {
  value       = module.role.name != "" ? module.role.name : null
  description = "The name of the created role"
}

output "role_id" {
  value       = module.role.id != "" ? module.role.id : null
  description = "The stable and unique string identifying the role"
}

output "role_arn" {
  value       = module.role.arn != "" ? module.role.arn : null
  description = "The Amazon Resource Name (ARN) specifying the role"
}

output "role_policy" {
  value       = module.role.policy != "" ? module.role.policy : null
  description = "The Amazon Resource Name (ARN) specifying the role"
}

output "key_arn" {
  value       = module.kms_key.key_arn != "" ? module.kms_key.key_arn : null
  description = "KMS key ARN"
}

output "key_id" {
  value       = module.kms_key.key_id != "" ? module.kms_key.key_id : null
  description = "KMS key ID"
}

output "key_alias_arn" {
  value       = module.kms_key.alias_arn != "" ? module.kms_key.alias_arn : null
  description = "KMS key alias ARN"
}

output "key_alias_name" {
  value       = module.kms_key.alias_name != "" ? module.kms_key.alias_name : null
  description = "KMS key alias name"
}

output "bucket_domain_name" {
  value       = module.bucket.bucket_domain_name != "" ? module.bucket.bucket_domain_name : null
  description = "FQDN of bucket"
}

output "bucket_id" {
  value       = module.bucket.bucket_id != "" ? module.bucket.bucket_id : null
  description = "Bucket Name (aka ID)"
}

output "bucket_arn" {
  value       = module.bucket.bucket_arn != "" ? module.bucket.bucket_arn : null
  description = "Bucket ARN"
}

output "user_name" {
  value       = module.bucket.user_name != "" ? module.bucket.user_name : null
  description = "Normalized IAM user name"
}

output "user_arn" {
  value       = module.bucket.user_arn != "" ? module.bucket.user_arn : null
  description = "The ARN assigned by AWS for the user"
}

output "user_unique_id" {
  value       = module.bucket.user_unique_id != "" ? module.bucket.user_unique_id : null
  description = "The user unique ID assigned by AWS"
}
