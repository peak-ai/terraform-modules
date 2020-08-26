# ☸ K8S_IRSA

`k8s_irsa` stands for `kubernetes IAM role for service account`
POD IAM Roles for service account allows User to attach IAM role directly to a POD instead of giving permissions to EC2 nodes for your `EKS cluster`.

`irsa` use `sts:AssumeRoleWithWebIdentity ` to assign permissions to your pod.
[Read more about EKS Pod IAM roles here](https://aws.amazon.com/about-aws/whats-new/2019/09/amazon-eks-adds-support-to-assign-iam-permissions-to-kubernetes-service-accounts/#:~:text=Now%2C%20Amazon%20EKS%20allows%20you,individual%20pod%20that%20you%20run.)

This module assumes that you already have OIDC Identity Provider Configured for your EKS cluster.

## Example usage

```hcl
provider "aws" {
    version = "~> 2.62"
}

module "tags" {
    source  = "git::https://github.com/peak-ai/terraform-modules.git//tags?ref=v0.6.0"
    tenant  = "new-client"
    stage   = "latest"
    feature = "example"
    service = "example"
}

resource "kubernetes_namespace" "example" {
  metadata {
    labels = module.tags.default
    name   = "my_ns"
  }
}

module "k8s_irsa" {
  depends_on      = [kubernetes_namespace.example]
  source          = "git::https://github.com/peak-ai/terraform-modules.git//k8s_irsa?ref=v0.6.0"
  cluster         = "my_cluster"
  namespace       = kubernetes_namespace.example.id
  service_account = "main"
  tags            = module.tags.default
  role_name       = "my_role"
  policy_name     = "my_policy"
  policy_doc      = <<EOF # this is just an example policy
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:ListBucket",
        "s3:ListBucketVersions",
        "s3:GetObjectVersion"
      ],
      "Resource": [
        "arn:aws:s3:::${local.s3_bucket}",
      ]
    }
  ]
}
EOF
}
```

## Requirements

| Name | Version |
|------|---------|
| aws | >= 2.62 |
| kubernetes | >= 1.11 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.62 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster | Name of K8S cluster | `string` | n/a | yes |
| namespace | K8S namespace (should already exist) | `string` | n/a | yes |
| policy\_doc | The inline policy document. This is a JSON formatted string. | `string` | n/a | yes |
| policy\_name | Name of policy. If not passed, will be generated randomly at runtime | `string` | `""` | no |
| role\_name | Name of IAM role. If not passed, will be generated randomly at runtime | `string` | `""` | no |
| service\_account | Service account that will be attached to IAM role. Should not exist already | `string` | n/a | yes |
| tags | Tags to pass | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| policy\_name | The name of the policy |
| role\_arn | The Amazon Resource Name (ARN) specifying the role |
| role\_name | The name of the role |
