provider "aws" {
  region = var.region
  default_tags {
    tags = var.tags
  }
}

data "aws_caller_identity" "current" {}
resource "aws_iam_role" "role" {
  name = "${var.name}-dax"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "dax.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

data "aws_subnet_ids" "vpc_subnets" {
  vpc_id = var.vpc_id
  tags = {
    Network = "Private"
  }
}

locals {
  table_arns = [for table in var.tables : [
    "arn:aws:dynamodb:${var.region}:${data.aws_caller_identity.current.account_id}:table/${table}",
    "arn:aws:dynamodb:${var.region}:${data.aws_caller_identity.current.account_id}:table/${table}/*"
  ]]
}


data "aws_iam_policy_document" "document" {
  statement {
    effect = "Allow"
    actions = [
      "dynamodb:DescribeTable",
      "dynamodb:PutItem",
      "dynamodb:GetItem",
      "dynamodb:UpdateItem",
      "dynamodb:DeleteItem",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:BatchGetItem",
      "dynamodb:BatchWriteItem",
      "dynamodb:ConditionCheckItem"
    ]
    resources = flatten(local.table_arns)
  }
}

resource "aws_iam_policy" "policy" {
  name        = "${var.name}-dax"
  description = "Dax access policy for cluster ${var.name}"

  policy = data.aws_iam_policy_document.document.json
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}

resource "aws_dax_parameter_group" "group" {
  name = var.name

  parameters {
    name  = "query-ttl-millis"
    value = var.query_cache_ttl__milli_second
  }

  parameters {
    name  = "record-ttl-millis"
    value = var.item_cache_ttl_milli_second
  }
}
resource "aws_dax_subnet_group" "subnet_group" {
  name       = var.name
  subnet_ids = data.aws_subnet_ids.vpc_subnets.ids
}

resource "aws_dax_cluster" "cluster" {
  cluster_name         = var.name
  iam_role_arn         = aws_iam_role.role.arn
  node_type            = var.node_type
  replication_factor   = var.replication_factor
  parameter_group_name = aws_dax_parameter_group.group.name
  subnet_group_name    = aws_dax_subnet_group.subnet_group.id
  server_side_encryption {
    enabled = true
  }
}
