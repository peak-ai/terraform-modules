## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| item\_cache\_ttl\_milli\_second | Time after which item cache will invalidate. Default 5 minutes | `number` | `300000` | no |
| name | n/a | `string` | n/a | yes |
| node\_type | n/a | `string` | `"dax.t2.small"` | no |
| query\_cache\_ttl\_\_milli\_second | Time after which item query will invalidate. Default 5 minutes | `number` | `300000` | no |
| region | n/a | `string` | n/a | yes |
| replication\_factor | n/a | `number` | `3` | no |
| tables | n/a | `list(string)` | n/a | yes |
| tags | n/a | `any` | n/a | yes |
| vpc\_id | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| endpoint\_created | Endpoint of the created cluster. |

## Example usage

```hcl
provider "aws" {
    version = "~> 2.62"
}

module "tags" {
    source  = "git::https://github.com/peak-ai/terraform-modules.git//tags?ref=v0.7.0"
    tenant  = "new-client"
    stage   = "latest"
    feature = "example"
    service = "example"
}

module "my_dax" {
  source  = "git::https://github.com/peak-ai/terraform-modules.git//dax?ref=v0.7.0"
  name    = "dax"
  tags    = module.tags.default
}
```
