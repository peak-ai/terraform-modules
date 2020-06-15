terraform {
  required_providers {
    null = "~> 2.1"
    aws  = ">= 2.62"
  }
}

module "git_branch" {
  source  = "matti/resource/shell"
  command = "git rev-parse --abbrev-ref HEAD"
}

module "git_sha" {
  source  = "matti/resource/shell"
  command = "git rev-parse HEAD"
}

locals {
  registry   = "${var.repository}/${var.service}"
  args       = join(" ", var.args)
  git_branch = lower(replace(module.git_branch.stdout, "/", "-"))
  git_sha    = module.git_sha.stdout
}

resource "null_resource" "build_image" {
  triggers = {
    image_tag = module.git_sha.stdout
  }

  provisioner "local-exec" {
    command = <<EOT
      aws ecr get-login-password \
        --region ${var.region} \
        | docker login \
        --username AWS \
        --password-stdin ${aws_ecr_repository.image_repo.repository_url};

      docker pull ${local.registry}:${local.git_branch} || true;
      docker build \
        --cache-from ${local.registry}:${local.git_branch} \
        --tag ${local.registry}:${local.git_branch} \
        --tag ${local.registry}:${local.git_sha} \
        --build-arg CI="true" \
        ${local.args} ${var.dockerfile};
      docker push ${local.registry}:${local.git_branch};
      docker push ${local.registry}:${local.git_sha};
    EOT
  }
}
