terraform {
  required_providers {
    aws = ">= 2.62"
  }
}

resource "aws_ecr_repository" "default" {
  name                 = var.name
  image_tag_mutability = var.image_tag_mutability
  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
  tags = var.tags
}

resource "aws_ecr_lifecycle_policy" "default" {
  repository = aws_ecr_repository.default.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep only N untagged image, expire all others",
            "selection": {
                "tagStatus": "untagged",
                "countType": "imageCountMoreThan",
                "countNumber": ${var.untagged_images_to_keep}
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}
