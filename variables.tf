variable "use_fullname" {
  type        = bool
  default     = true
  description = <<-EOT
  If set to 'true' then the full ID for the IAM role name (e.g. `[var.namespace]-[var.environment]-[var.stage]`) will be used.

  Otherwise, `var.name` will be used for the IAM role name.
  EOT
}

variable "principals" {
  type        = map(list(string))
  description = "Map of service name as key and a list of ARNs to allow assuming the role as value (e.g. map(`AWS`, list(`arn:aws:iam:::role/admin`)))"
  default     = {}
}

variable "policy_documents" {
  type        = list(string)
  description = "List of JSON IAM policy documents"
  default     = []
}

variable "policy_document_count" {
  type        = number
  description = "Number of policy documents (length of policy_documents list)"
  default     = 1
}

variable "managed_policy_arns" {
  type        = set(string)
  description = <<-EOT
    A list of IAM Policy ARNs to attach to the created role.
    Changes to the list will have ripple effects, so use `managed_policy_arns_map` if possible.
    EOT
  default     = []
}

variable "managed_policy_arns_map" {
  type        = map(string)
  description = <<-EOT
    A map of name to IAM Policy ARNs to attach to the created role.
    The names are arbitrary, but must be known at plan time. The purpose of the name
    is so that changes to one ARN do not cause a ripple effect on the other ARNs.
    If you cannot provide unique names known at plan time, use `managed_policy_arns` instead.
    EOT
  default     = {}
}

variable "max_session_duration" {
  type        = number
  default     = 3600
  description = "The maximum session duration (in seconds) for the role. Can have a value from 1 hour to 12 hours"
}

variable "permissions_boundary" {
  type        = string
  default     = ""
  description = "ARN of the policy that is used to set the permissions boundary for the role"
}

variable "role_description" {
  type        = string
  description = "The description of the IAM role that is visible in the IAM role manager"
}

variable "policy_name" {
  type        = string
  description = "The name of the IAM policy that is visible in the IAM policy manager"
  default     = null
}

variable "policy_description" {
  type        = string
  default     = ""
  description = "The description of the IAM policy that is visible in the IAM policy manager"
}

variable "assume_role_actions" {
  type        = list(string)
  default     = ["sts:AssumeRole", "sts:TagSession"]
  description = "The IAM action to be granted by the AssumeRole policy"
}

variable "assume_role_conditions" {
  type = list(object({
    test     = string
    variable = string
    values   = list(string)
  }))
  description = "List of conditions for the assume role policy"
  default     = []
}

variable "instance_profile_enabled" {
  type        = bool
  default     = false
  description = "Create EC2 Instance Profile for the role"
}

variable "path" {
  type        = string
  description = "Path to the role and policy. See [IAM Identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html) for more information."
  default     = "/"
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
