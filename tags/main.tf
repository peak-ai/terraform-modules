locals {
  tags = {
    stage   = lower(var.stage)
    tenant  = lower(var.tenant)
    feature = lower(var.feature)
    service = lower(var.service)
  }
}
