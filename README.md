<img src=".github/images/peak.gif" alt="Peak" width="100" height="100" />

# ![T](.github/images/terraform.png)erraform-modules

![Build](https://github.com/peak-ai/terraform-modules/workflows/Build/badge.svg) ![stable](https://img.shields.io/github/v/release/peak-ai/terraform-modules) ![](https://img.shields.io/github/v/release/peak-ai/terraform-modules?include_prereleases) ![](https://img.shields.io/github/license/peak-ai/terraform-modules) ![](https://img.shields.io/github/languages/count/peak-ai/terraform-modules) ![](https://img.shields.io/github/languages/top/peak-ai/terraform-modules) ![](https://img.shields.io/github/issues-raw/peak-ai/terraform-modules) ![](https://img.shields.io/github/issues-pr-raw/peak-ai/terraform-modules)

This repo list some open to use Terraform modules we use at `Peak AI` because we :heart: IAC(Infrastucture as Code) and Terraform modules are a great way to write reusable Infra.

## List of avilable modules


- AWS
    - [:open_file_folder: S3](/s3)
    - [:camera: ECR](/ecr)
- Misclleneous
    - [:bookmark: Tags (aka Labels)](/tags)

## Example usage

There are two approaches to import and use modules in this repo.

### Using specific revision (recommended approach)
`Blueprint`
```hcl
module "<name_you_want_to_give_to_this_module>" {
    source  = "git@github.com:peak-ai/terraform-modules.git//<name_of_folder/module_to_use>?ref=<github_tag/release/commit>"
    .
    .
    .
    # Add inputs here you want to overwrite
}
```
`Example`
```hcl
module "tags" {
    source  = "git@github.com:peak-ai/terraform-modules.git//tags?ref=v0.1.0"
    stage   = "latest"
    feature = "example"
    service = "example"
}
```

### Importing latest version (Use this approach at your own risk as there can be breaking changes)

`Blueprint`
```hcl
module "<name_you_want_to_give_to_this_module>" {
    source  = "git@github.com:peak-ai/terraform-modules.git//<name_of_folder/module_to_use>"
    .
    .
    .
    # Add inputs here you want to overwrite
}
```

`Example`
```hcl
module "tags" {
    source  = "git@github.com:peak-ai/terraform-modules.git//tags"
    stage   = "latest"
    feature = "example"
    service = "example"
}
```


## Contributing

Despite being primarily maintained by Peak, we welcome and appreciate any contributions from the community! Please see the [contribution guidelines](CONTRIBUTING.md) for more info.
