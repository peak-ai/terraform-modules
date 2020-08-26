# :construction: Builds Docker Image as Part of Infra and pushes to ECR

## Gist

This module allows you to build a docker image as part of the terraform deployment, which can then be used as part of other
infrastructure, for example deploying to kubernetes, or to ECS or beanstalk.

This is good because it allows us to make use of environment variables and other configs which are already part of our terraform
infrastructure deployment. You'll be able to provision infrastructure, build a docker image and deploy the docker image in one command
rather than a series of commands, which is what you'd traditionally have to do in CodePipeline or CodeBuild.

## Requirements

| Name | Version |
|------|---------|
| aws | >= 2.62 |
| null | ~> 2.1 |

## Providers

| Name | Version |
|------|---------|
| null | ~> 2.1 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| args | A key value list of additional arguments to be passed into the docker build | `list(string)` | `[]` | no |
| git\_branch | The git branch | `string` | n/a | yes |
| git\_sha | The SHA of the git commit | `string` | n/a | yes |
| path | Path where the dockerfile exists | `string` | n/a | yes |
| region | The AWS region to use | `string` | n/a | yes |
| repository\_url | URL of the ECR repository | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| image | The full path to the docker image |
| tags | The image tags that have been built |

## Example usage

```hcl
provider "aws" {
  version = "~> 2.62"
}

provider "null" {
  version = "~> 2.1"
}

locals {
  npm_token = "123"
}

module "my_docker_builder" {
  source     = "git::https://github.com/peak-ai/terraform-modules.git//docker_builder?ref=v0.4.0"
  # Here we use the repo which has been created in the basic example. (If you were doing this, you wouldnt hard code these values)
  repository_url = "<account_id>.dkr.ecr.<region>.amazonaws.com/latest-my-example"
  dockerfile = "./Dockerfile"
  args       = ["--build-arg NPM_TOKEN=${local.npm_token}"]
}
```
