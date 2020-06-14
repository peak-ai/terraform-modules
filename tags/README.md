# :bookmark: Tags

`Tags` for AWS Resources or `Labels` for Kubernetes objects allows Users to add metadta to Resource/Objects. Each tag is simple key-value pair which makes it easier to manage, search for, and filter resources.

This module defines base `tags` we here at Peak assign to each of our resources and are just a base Idea. You might want change that as per your organisation's needs. In that  case feel free to fork this repo and define base tags that fits your organisation needs.


## Gist

All tags and their values are converted to lower case to avoid confusions and duplications

`stage`: Stagging environment the resource belogs to. Must be one of [latest, test, beta, prod]

`tenant`: Tenant the resource belongs to. Defaults to `platform`

`feature`: Feature this resource belogs to say `shopping-cart`

`service`: Service this resource belogs to say `shopiing-cart-database`

## Example usage

Once initialised tags added to as many resources as you want.

### Example 1 > Using latest module

```hcl
# Importing module
module "tags" {
    source  = "git::https://github.com/peak-ai/terraform-modules.git//tags"
    # Passing values from here will overide the default values
    tenant  = "new-client"
    # It is good practice to make workspaces matching four staging environment rather than hardcoing them
    stage   = terraform.workspace
    # hardcoing example
    # stage = "latest"
    feature = "example"
    service = "example"
}

# Using module to to add tags to a resource say a S3 bucket
provider "aws" {
    version = "~> 2.62"
}

resource "aws_s3_bucket" "example" {
  bucket = "example"
  tags   = module.tags.default
}
```
### Example 2 > Minimal using specific version

```hcl
module "tags" {
    source  = "git::https://github.com/peak-ai/terraform-modules.git//tags?ref=v0.1.0"
    tenant  = "new-client"
    stage   = "latest"
    feature = "example"
    service = "example"
}

provider "aws" {
    version = "~> 2.62"
}

resource "aws_s3_bucket" "example" {
  bucket = "example"
  tags   = module.tags.default
}
```

### Example 3 > Adding tags ( aka labels) to K8S objects

You can assign tags to any kubernetes object as well

```hcl
module "tags" {
    source  = "git::https://github.com/peak-ai/terraform-modules.git//tags?ref=v0.1.0"
    tenant  = "new-client"
    stage   = "latest"
    feature = "example"
    service = "example"
}

provider "kubernetes" {
    version = "~> 1.11"
}

resource "kubernetes_namespace" "example" {
    metadata {
        labels = module.tags.default
        name = "example"
    }
}
```
