variable "region" {
  type        = string
  description = "AWS region"
}

variable "use_fullname" {
  type        = bool
  description = "Set 'true' to use `namespace-stage-name` for ecr repository name, else `name`"
}

variable "principals" {
  type        = map(list(string))
  description = "Map of service name as key and a list of ARNs to allow assuming the role as value (e.g. map(`AWS`, list(`arn:aws:iam:::role/admin`)))"
}

variable "inline_policy_enabled" {
  type        = bool
  description = "Whether or not to enable an inline policy instead of a reusable managed policy"
  default     = false
}

variable "assume_role_policy" {
  type        = string
  description = "A JSON assume role policy document. If set, this will be used as the assume role policy and the principals, assume_role_conditions, and assume_role_actions variables will be ignored."
  default     = null
}
