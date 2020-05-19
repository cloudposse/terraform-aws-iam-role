output "role_name" {
  value       = "${module.role.name}"
  description = "The name of the created role"
}

output "role_id" {
  value       = "${module.role.id}"
  description = "The stable and unique string identifying the role"
}

output "role_arn" {
  value       = "${module.role.arn}"
  description = "The Amazon Resource Name (ARN) specifying the role"
}

output "role_policy" {
  value       = "${module.role.policy}"
  description = "The Amazon Resource Name (ARN) specifying the role"
}