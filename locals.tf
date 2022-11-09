locals {
  namespace = var.create_namespace ? kubernetes_namespace.this[0].metadata[0].name : var.namespace
  env = flatten([
    for name, value in lookup(var.container, "env", {}) : {
      name  = tostring(name)
      value = tostring(value)
    }
  ])
  service_account_name = var.create_service_account ? kubernetes_service_account.main[0].metadata[0].name : var.deployment_name
  svc_ports = flatten([
    for name, value in var.service : {
      name        = tostring(name)
      protocol    = value.protocol
      port        = value.port
      target_port = value.target_port
    }
  ])
  ingress_rules = flatten([
    for name, value in var.ingress_rules : {
      host      = value.host
      path      = value.path
      path_type = value.path_type
      port      = value.port
    }
  ])
}