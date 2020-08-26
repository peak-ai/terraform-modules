# :open_file_folder: S3

Amazon Simple Storage Service (Amazon S3) is an object storage service that offers industry-leading scalability, data availability, security, and performance.

For more information about `S3` check [AWS Docs](https://aws.amazon.com/s3/)

## Gist
This module definines minimal, secure S3 bucket configuration.

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
| acl | n/a | `string` | `"bucket-owner-full-control"` | no |
| block\_public\_acls | n/a | `bool` | `true` | no |
| block\_public\_policy | n/a | `bool` | `true` | no |
| enable\_versioning | n/a | `bool` | `false` | no |
| ignore\_public\_acls | n/a | `bool` | `true` | no |
| name | Name of S3 bucket | `string` | n/a | yes |
| restrict\_public\_buckets | n/a | `bool` | `true` | no |
| tags | Tags to pass | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | The ARN of the bucket. Will be of format arn:aws:s3:::bucketname |
| id | The name of the bucket |

## Example usage

```hcl
provider "aws" {
    version = "~> 2.62"
}

module "tags" {
    source  = "git::https://github.com/peak-ai/terraform-modules.git//tags?ref=v0.2.0"
    tenant  = "new-client"
    stage   = "latest"
    feature = "example"
    service = "example"
}

module "my_s3" {
  source  = "git::https://github.com/peak-ai/terraform-modules.git//s3?ref=v0.2.0"
  name    = "s3"
  tags    = module.tags.default
}
```
