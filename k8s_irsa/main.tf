terraform {
  required_providers {
    aws        = ">= 2.62"
    kubernetes = ">= 1.11"
  }
}

data "aws_caller_identity" "current" {}
data "aws_eks_cluster" "this" {
  name = var.cluster
}

locals {
  oidc = replace(data.aws_eks_cluster.this.identity[0].oidc[0].issuer, "https://", "")
}

# IAM Role that will be used by app POD for access via web tokens
resource "aws_iam_role" "this" {
  name               = var.role_name
  tags               = var.tags
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Principal": {
        "Federated": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${local.oidc}"
      },
      "Condition": {
        "StringEquals": {
          "${local.oidc}:sub": "system:serviceaccount:${var.namespace}:${var.service_account}"
        }
      }
    }
  ]
}
EOF
}

# IAM Policy to be attched to the role
resource "aws_iam_policy" "this" {
  name   = var.policy_name
  policy = var.policy_doc
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}

/*
Service account to which IAM role will be attached. A new account is created here
because Terraform doesn't support modifying existing this account
*/
resource "kubernetes_service_account" "this" {
  metadata {
    name      = var.service_account
    namespace = var.namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.this.arn
    }
  }
  automount_service_account_token = true
}
