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
