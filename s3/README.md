# :open_file_folder: S3

Amazon Simple Storage Service (Amazon S3) is an object storage service that offers industry-leading scalability, data availability, security, and performance.

For more information about `S3` check [AWS Docs](https://aws.amazon.com/s3/)

## Gist
This module definines minimal, secure S3 bucket configuration.

## Example usage

```hcl
module "tags" {
    source  = "git@github.com:peak-ai/terraform-modules.git//tags?ref=v0.1.0"
    tenant  = "new-client"
    stage   = "latest"
    feature = "example"
    service = "example"
}

provider "aws" {
    version = "~> 2.62"
}

module "my_s3" {
  source  = "git@github.com:peak-ai/terraform-modules.git//s3?ref=v0.2.0"
  name = "s3"
  tags = module.tags.default
}
```
