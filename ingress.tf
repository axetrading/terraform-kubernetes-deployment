resource "kubernetes_ingress_v1" "main" {
  count = var.enable_ingress && var.ingress_rules != {} ? 1 : 0
  metadata {
    name      = var.deployment_name
    namespace = local.namespace
  }

  spec {
    dynamic "rule" {
      for_each = local.ingress_rules
      content {
        host = rule.value.host
        http {
          path {
            path      = rule.value.path
            path_type = rule.value.path_type

            backend {
              service {
                name = var.deployment_name

                port {
                  number = 80
                }
              }
            }
          }
        }
      }
    }
  }
}

