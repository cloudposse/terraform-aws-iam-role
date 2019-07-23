variable "namespace" {
  type        = "string"
  description = "Namespace (e.g. `cp` or `cloudposse`)"
}

variable "stage" {
  type        = "string"
  description = "Stage (e.g. `prod`, `dev`, `staging`)"
}

variable "name" {
  type        = "string"
  description = "Name (e.g. `app` or `chamber`)"
}

variable "use_fullname" {
  type        = "string"
  default     = "true"
  description = "Set 'true' to use `namespace-stage-name` for ecr repository name, else `name`"
}

variable "delimiter" {
  type        = "string"
  default     = "-"
  description = "Delimiter to be used between `namespace`, `stage`, `name` and `attributes`"
}

variable "attributes" {
  type        = "list"
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)"
}

variable "principals" {
  type        = "map"
  description = "Map of service name as key and a list of ARNs to allow assuming the role as value. (e.g. map(`AWS`, list(`arn:aws:iam:::role/admin`)))"
  default     = {}
}

variable "policy_documents" {
  type        = "list"
  description = "List of JSON IAM policy documents"
  default     = []
}

variable "policy_document_count" {
  description = "Number of policy documents (length of policy_documents list)."
  default     = 1
}

variable "max_session_duration" {
  default     = 3600
  description = "The maximum session duration (in seconds) for the role. Can have a value from 1 hour to 12 hours"
}

variable "enabled" {
  type        = "string"
  description = "Set to `false` to prevent the module from creating any resources"
  default     = "true"
}

variable "role_description" {
  type        = "string"
  description = "The description of the IAM role that is visible in the IAM role manager"
}

variable "policy_description" {
  type        = "string"
  description = "The description of the IAM policy that is visible in the IAM policy manager"
}
