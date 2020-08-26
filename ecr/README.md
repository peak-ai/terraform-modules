# :camera: ECR

Amazon Elastic Container Registry (ECR) is a fully-managed Docker container registry that makes it easy for developers to store, manage, and deploy Docker container images.

For more information about `ECR` check [AWS Docs](https://aws.amazon.com/ecr/)

## Gist

This module defines ECR repo with tags and life cycle policy which removes N untagged images

## Requirements

| Name | Version |
|------|---------|
| aws | >= 2.62 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.62 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| image\_tag\_mutability | n/a | `string` | `"MUTABLE"` | no |
| name | Name of ECR bucket | `string` | n/a | yes |
| scan\_on\_push | n/a | `bool` | `true` | no |
| tags | Tags to pass | `object` | n/a | yes |
| untagged\_images\_to\_keep | n/a | `number` | `5` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | Full ARN of the repository |
| name | The name of the repository |
| registry\_id | The registry ID where the repository was created |
| repository\_url | The URL of the repository (in the form aws\_account\_id.dkr.ecr.region.amazonaws.com/repositoryName) |

## Example usage

```hcl
provider "aws" {
    version = "~> 2.62"
}
module "tags" {
    source  = git::https://github.com/peak-ai/terraform-modules.git//tags?ref=v0.3.0"
    tenant  = "new-client"
    stage   = "latest"
    feature = "example"
    service = "example"
}

module "my_ecr" {
  source  = "git::https://github.com/peak-ai/terraform-modules.git//ecr?ref=v0.3.0"
  name    = "my_ecr"
  tags    = module.tags.default
}
```
