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

variable "max_session_duration" {
  type        = number
  default     = 3600
  description = "The maximum session duration (in seconds) for the role. Can have a value from 1 hour to 12 hours"
}

variable "role_description" {
  type        = string
  description = "The description of the IAM role that is visible in the IAM role manager"
}

variable "policy_description" {
  type        = string
  description = "The description of the IAM policy that is visible in the IAM policy manager"
}

variable "assume_role_action" {
  type = string
  default = "sts:AssumeRole"
  description = "The IAM action to be granted by the AssumeRole policy"
}
