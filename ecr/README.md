# :camera: ECR

Amazon Elastic Container Registry (ECR) is a fully-managed Docker container registry that makes it easy for developers to store, manage, and deploy Docker container images.

For more information about `ECR` check [AWS Docs](https://aws.amazon.com/ecr/)

## Gist

This module defines ECR repo with tags and life cycle policy which removes N untagged images

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
