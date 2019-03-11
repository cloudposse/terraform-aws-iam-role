## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| attributes | Additional attributes (e.g. `1`) | list | `<list>` | no |
| delimiter | Delimiter to be used between `namespace`, `stage`, `name` and `attributes` | string | `-` | no |
| enabled | Set to `false` to prevent the module from creating any resources | string | `true` | no |
| max_session_duration | The maximum session duration (in seconds) for the role. Can have a value from 1 hour to 12 hours | string | `3600` | no |
| name | Name (e.g. `app` or `chamber`) | string | - | yes |
| namespace | Namespace (e.g. `cp` or `cloudposse`) | string | - | yes |
| policy_description | The description of the IAM policy that is visible in the IAM policy manager | string | - | yes |
| policy_documents | List of JSON IAM policy documents | list | `<list>` | no |
| principals_arns | List of ARNs to allow assuming the role. Could be AWS services or accounts, Kops nodes, IAM users or groups | list | - | yes |
| role_description | The description of the IAM role that is visible in the IAM role manager | string | - | yes |
| stage | Stage (e.g. `prod`, `dev`, `staging`) | string | - | yes |
| tags | Additional tags (e.g. map(`BusinessUnit`,`XYZ`) | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | The Amazon Resource Name (ARN) specifying the role |
| id | The stable and unique string identifying the role |
| name | The name of the IAM role created |
| policy | Role policy document in json format. Outputs always, independent of `enabled` variable |

