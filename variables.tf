variable "use_fullname" {
  type        = bool
  default     = true
  description = "Set 'true' to use `namespace-stage-name` for ecr repository name, else `name`"
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
  description = "List of managed policies to attach to created role"
  default     = []
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
