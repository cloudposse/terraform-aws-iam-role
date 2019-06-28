<!-- This file was automatically generated by the `build-harness`. Make all changes to `README.yaml` and run `make readme` to rebuild this file. -->
[![README Header][readme_header_img]][readme_header_link]

[![Cloud Posse][logo]](https://cpco.io/homepage)

# terraform-aws-iam-role [![Build Status](https://g.codefresh.io/api/badges/pipeline/cloudposse/cloudposse%2Fterraform-aws-iam-role%2Flint?type=cf-1)](https://g.codefresh.io/public/accounts/cloudposse/pipelines/cloudposse/terraform-aws-iam-role/lint) [![Latest Release](https://img.shields.io/github/release/cloudposse/terraform-aws-iam-role.svg)](https://github.com/cloudposse/terraform-aws-iam-role/releases/latest) [![Slack Community](https://slack.cloudposse.com/badge.svg)](https://slack.cloudposse.com)


A Terraform module that creates IAM role with provided JSON IAM polices documents.

#### Warning

* If `var.enabled` set `false` the module can be used as [IAM Policy Document Aggregator](https://github.com/cloudposse/terraform-aws-iam-policy-document-aggregator)
because [`output.policy`](https://github.com/cloudposse/terraform-aws-iam-role/tree/init#outputs) always aggregates [`var.policy_documents`](https://github.com/cloudposse/terraform-aws-iam-role/tree/init#inputs)
* List size [`var.policy_documents`](https://github.com/cloudposse/terraform-aws-iam-role/tree/init#inputs) [limited to 10](https://github.com/cloudposse/terraform-aws-iam-policy-document-aggregator#inputs)


---

This project is part of our comprehensive ["SweetOps"](https://cpco.io/sweetops) approach towards DevOps. 
[<img align="right" title="Share via Email" src="https://docs.cloudposse.com/images/ionicons/ios-email-outline-2.0.1-16x16-999999.svg"/>][share_email]
[<img align="right" title="Share on Google+" src="https://docs.cloudposse.com/images/ionicons/social-googleplus-outline-2.0.1-16x16-999999.svg" />][share_googleplus]
[<img align="right" title="Share on Facebook" src="https://docs.cloudposse.com/images/ionicons/social-facebook-outline-2.0.1-16x16-999999.svg" />][share_facebook]
[<img align="right" title="Share on Reddit" src="https://docs.cloudposse.com/images/ionicons/social-reddit-outline-2.0.1-16x16-999999.svg" />][share_reddit]
[<img align="right" title="Share on LinkedIn" src="https://docs.cloudposse.com/images/ionicons/social-linkedin-outline-2.0.1-16x16-999999.svg" />][share_linkedin]
[<img align="right" title="Share on Twitter" src="https://docs.cloudposse.com/images/ionicons/social-twitter-outline-2.0.1-16x16-999999.svg" />][share_twitter]


[![Terraform Open Source Modules](https://docs.cloudposse.com/images/terraform-open-source-modules.svg)][terraform_modules]



It's 100% Open Source and licensed under the [APACHE2](LICENSE).







We literally have [*hundreds of terraform modules*][terraform_modules] that are Open Source and well-maintained. Check them out! 







## Usage


**IMPORTANT:** The `master` branch is used in `source` just as an example. In your code, do not pin to `master` because there may be breaking changes between releases.
Instead pin to the release tag (e.g. `?ref=tags/x.y.z`) of one of our [latest releases](https://github.com/cloudposse/terraform-aws-iam-role/releases).


This example creates a role with the name `cp-prod-app` with permission to grant read-write access to S3 bucket,
and gives permission to the entities specified in `principals_arns` to assume the role.

```hcl

  data "aws_iam_policy_document" "resource_full_access" {
    statement {
      sid       = "FullAccess"
      effect    = "Allow"
      resources = ["arn:aws:s3:::bucketname/path/*"]

      actions = [
        "s3:PutObject",
        "s3:PutObjectAcl",
        "s3:GetObject",
        "s3:DeleteObject",
        "s3:ListBucket",
        "s3:ListBucketMultipartUploads",
        "s3:GetBucketLocation",
        "s3:AbortMultipartUpload",
      ]
    }
  }

  data "aws_iam_policy_document" "base" {
    statement {
      sid = "BaseAccess"

      actions = [
        "s3:ListBucket",
        "s3:ListBucketVersions",
      ]

      resources = ["arn:aws:s3:::bucketname"]
      effect    = "Allow"
    }
  }

  module "role" {
    source     = "git::https://github.com/cloudposse/terraform-aws-iam-role.git?ref=master"

    enabled    = "true"
    namespace = "cp"
    stage     = "prod"
    name      = "app"

    policy_description = "Allow S3 FullAccess"
    role_description   = "IAM role with permissions to perform actions on S3 resources"

    principals = {
      AWS = ["arn:aws:iam::123456789012:role/workers"]
    }
    
    policy_documents = [
      "${data.aws_iam_policy_document.resource_full_access.json}",
      "${data.aws_iam_policy_document.base.json}",
    ]
  }
```

### Additional Examples
The [`example`](./example) directory contains complete working examples with variations of how to use the module.






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
| principals | Map of service name as key and a list of ARNs to allow assuming the role as value. (e.g. map(`AWS`, list(`arn:aws:iam:::role/admin`))) | map | `<map>` | no |
| role_description | The description of the IAM role that is visible in the IAM role manager | string | - | yes |
| stage | Stage (e.g. `prod`, `dev`, `staging`) | string | - | yes |
| tags | Additional tags (e.g. map(`BusinessUnit`,`XYZ`) | map | `<map>` | no |
| use_fullname | Set 'true' to use `namespace-stage-name` for ecr repository name, else `name` | string | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | The Amazon Resource Name (ARN) specifying the role |
| id | The stable and unique string identifying the role |
| name | The name of the IAM role created |
| policy | Role policy document in json format. Outputs always, independent of `enabled` variable |




## Share the Love 

Like this project? Please give it a ★ on [our GitHub](https://github.com/cloudposse/terraform-aws-iam-role)! (it helps us **a lot**) 

Are you using this project or any of our other projects? Consider [leaving a testimonial][testimonial]. =)


## Related Projects

Check out these related projects.

- [terraform-aws-iam-policy-document-aggregator](https://github.com/cloudposse/terraform-aws-iam-policy-document-aggregator) - Terraform module to aggregate multiple IAM policy documents into single policy document
- [terraform-aws-iam-chamber-s3-role](https://github.com/cloudposse/terraform-aws-iam-chamber-s3-role) - Terraform module to provision an IAM role with configurable permissions to access S3 as chamber backend



## Help

**Got a question?**

File a GitHub [issue](https://github.com/cloudposse/terraform-aws-iam-role/issues), send us an [email][email] or join our [Slack Community][slack].

[![README Commercial Support][readme_commercial_support_img]][readme_commercial_support_link]

## Commercial Support

Work directly with our team of DevOps experts via email, slack, and video conferencing. 

We provide [*commercial support*][commercial_support] for all of our [Open Source][github] projects. As a *Dedicated Support* customer, you have access to our team of subject matter experts at a fraction of the cost of a full-time engineer. 

[![E-Mail](https://img.shields.io/badge/email-hello@cloudposse.com-blue.svg)][email]

- **Questions.** We'll use a Shared Slack channel between your team and ours.
- **Troubleshooting.** We'll help you triage why things aren't working.
- **Code Reviews.** We'll review your Pull Requests and provide constructive feedback.
- **Bug Fixes.** We'll rapidly work to fix any bugs in our projects.
- **Build New Terraform Modules.** We'll [develop original modules][module_development] to provision infrastructure.
- **Cloud Architecture.** We'll assist with your cloud strategy and design.
- **Implementation.** We'll provide hands-on support to implement our reference architectures. 



## Terraform Module Development

Are you interested in custom Terraform module development? Submit your inquiry using [our form][module_development] today and we'll get back to you ASAP.


## Slack Community

Join our [Open Source Community][slack] on Slack. It's **FREE** for everyone! Our "SweetOps" community is where you get to talk with others who share a similar vision for how to rollout and manage infrastructure. This is the best place to talk shop, ask questions, solicit feedback, and work together as a community to build totally *sweet* infrastructure.

## Newsletter

Signup for [our newsletter][newsletter] that covers everything on our technology radar.  Receive updates on what we're up to on GitHub as well as awesome new projects we discover. 

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/cloudposse/terraform-aws-iam-role/issues) to report any bugs or file feature requests.

### Developing

If you are interested in being a contributor and want to get involved in developing this project or [help out](https://cpco.io/help-out) with our other projects, we would love to hear from you! Shoot us an [email][email].

In general, PRs are welcome. We follow the typical "fork-and-pull" Git workflow.

 1. **Fork** the repo on GitHub
 2. **Clone** the project to your own machine
 3. **Commit** changes to your own branch
 4. **Push** your work back up to your fork
 5. Submit a **Pull Request** so that we can review your changes

**NOTE:** Be sure to merge the latest changes from "upstream" before making a pull request!


## Copyright

Copyright © 2017-2019 [Cloud Posse, LLC](https://cpco.io/copyright)



## License 

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) 

See [LICENSE](LICENSE) for full details.

    Licensed to the Apache Software Foundation (ASF) under one
    or more contributor license agreements.  See the NOTICE file
    distributed with this work for additional information
    regarding copyright ownership.  The ASF licenses this file
    to you under the Apache License, Version 2.0 (the
    "License"); you may not use this file except in compliance
    with the License.  You may obtain a copy of the License at

      https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.









## Trademarks

All other trademarks referenced herein are the property of their respective owners.

## About

This project is maintained and funded by [Cloud Posse, LLC][website]. Like it? Please let us know by [leaving a testimonial][testimonial]!

[![Cloud Posse][logo]][website]

We're a [DevOps Professional Services][hire] company based in Los Angeles, CA. We ❤️  [Open Source Software][we_love_open_source].

We offer [paid support][commercial_support] on all of our projects.  

Check out [our other projects][github], [follow us on twitter][twitter], [apply for a job][jobs], or [hire us][hire] to help with your cloud strategy and implementation.



### Contributors

|  [![Igor Rodionov][goruha_avatar]][goruha_homepage]<br/>[Igor Rodionov][goruha_homepage] | [![Oscar Sullivan][osulli_avatar]][osulli_homepage]<br/>[Oscar Sullivan][osulli_homepage] |
|---|---|

  [goruha_homepage]: https://github.com/goruha
  [goruha_avatar]: https://github.com/goruha.png?size=150
  [osulli_homepage]: https://github.com/osulli
  [osulli_avatar]: https://github.com/osulli.png?size=150



[![README Footer][readme_footer_img]][readme_footer_link]
[![Beacon][beacon]][website]

  [logo]: https://cloudposse.com/logo-300x69.svg
  [docs]: https://cpco.io/docs
  [website]: https://cpco.io/homepage
  [github]: https://cpco.io/github
  [jobs]: https://cpco.io/jobs
  [hire]: https://cpco.io/hire
  [slack]: https://cpco.io/slack
  [linkedin]: https://cpco.io/linkedin
  [twitter]: https://cpco.io/twitter
  [testimonial]: https://cpco.io/leave-testimonial
  [newsletter]: https://cpco.io/newsletter
  [email]: https://cpco.io/email
  [commercial_support]: https://cpco.io/commercial-support
  [we_love_open_source]: https://cpco.io/we-love-open-source
  [module_development]: https://cpco.io/module-development
  [terraform_modules]: https://cpco.io/terraform-modules
  [readme_header_img]: https://cloudposse.com/readme/header/img?repo=cloudposse/terraform-aws-iam-role
  [readme_header_link]: https://cloudposse.com/readme/header/link?repo=cloudposse/terraform-aws-iam-role
  [readme_footer_img]: https://cloudposse.com/readme/footer/img?repo=cloudposse/terraform-aws-iam-role
  [readme_footer_link]: https://cloudposse.com/readme/footer/link?repo=cloudposse/terraform-aws-iam-role
  [readme_commercial_support_img]: https://cloudposse.com/readme/commercial-support/img?repo=cloudposse/terraform-aws-iam-role
  [readme_commercial_support_link]: https://cloudposse.com/readme/commercial-support/link?repo=cloudposse/terraform-aws-iam-role
  [share_twitter]: https://twitter.com/intent/tweet/?text=terraform-aws-iam-role&url=https://github.com/cloudposse/terraform-aws-iam-role
  [share_linkedin]: https://www.linkedin.com/shareArticle?mini=true&title=terraform-aws-iam-role&url=https://github.com/cloudposse/terraform-aws-iam-role
  [share_reddit]: https://reddit.com/submit/?url=https://github.com/cloudposse/terraform-aws-iam-role
  [share_facebook]: https://facebook.com/sharer/sharer.php?u=https://github.com/cloudposse/terraform-aws-iam-role
  [share_googleplus]: https://plus.google.com/share?url=https://github.com/cloudposse/terraform-aws-iam-role
  [share_email]: mailto:?subject=terraform-aws-iam-role&body=https://github.com/cloudposse/terraform-aws-iam-role
  [beacon]: https://ga-beacon.cloudposse.com/UA-76589703-4/cloudposse/terraform-aws-iam-role?pixel&cs=github&cm=readme&an=terraform-aws-iam-role
