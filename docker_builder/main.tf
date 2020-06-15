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
  args       = join(" ", var.args)
  git_branch = lower(replace(module.git_branch.stdout, "/", "-"))
  git_sha    = module.git_sha.stdout

  tag = "${var.repository_url}:${local.git_branch}"
  extra_tags = local.git_branch == "master" ? ["${var.repository_url}:${local.git_sha}", "${var.repository_url}:latest"] : ["${var.repository_url}:${local.git_sha}"]
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
        --password-stdin ${var.repository_url};

      docker pull ${local.tag} || true;
      docker build \
        --cache-from ${local.tag} \
        --tag ${local.tag} \
        --build-arg CI="true" \
        ${local.args} ${var.dockerfile};
      docker push ${local.tag};

      %{ for tag in local.extra_tags }
        docker tag ${local.tag} ${tag}
        docker push ${tag}
      %{ endfor }
    EOT
  }
}
