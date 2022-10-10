## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.62 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| item\_cache\_ttl\_milli\_second | Time after which item cache will invalidate. Default 5 minutes | `number` | `300000` | no |
| name | n/a | `string` | n/a | yes |
| node\_type | (Required) The compute and memory capacity of the nodes | `string` | `"dax.t2.small"` | no |
| query\_cache\_ttl\_\_milli\_second | Time after which item query will invalidate. Default 5 minutes | `number` | `300000` | no |
| region | n/a | `string` | n/a | yes |
| replication\_factor | (Required) The number of nodes in the DAX cluster | `number` | `3` | no |
| security_group_ids | The list of Security Group IDs to be associated with the DAX cluster | `list(string)` | n/a | yes |
| tables | List of tables for using dax | `list(string)` | n/a | yes |
| tags | A map of tags to assign to the resource | `any` | n/a | yes |
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
  source                        = "git::https://github.com/peak-ai/terraform-modules.git//dax?ref=v0.7.0"
  name                          = "dax"
  tags                          = module.tags.default
  region                        = "example_region"
  vpc_id                        = "example_vpc_id"
  node_type                     = "dax.t2.small"
  replication_factor            = 3
  query_cache_ttl__milli_second = 30 * 1000
  item_cache_ttl_milli_second   = 30 * 60 * 1000
  security_group_ids = [
    "sg-123456789",
    "sg-987654321"
  ]
  tables = [
    "table1",
    "table2"
  ]
}
```
