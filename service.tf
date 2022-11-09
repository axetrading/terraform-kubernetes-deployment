resource "kubernetes_service" "main" {
  metadata {
    name      = var.deployment_name
    namespace = local.namespace

    labels = {
      "app.kubernetes.io/instance" = var.deployment_name
      "app.kubernetes.io/name"     = var.deployment_name

    }
  }
  spec {
    dynamic "port" {
      for_each = local.svc_ports
      content {
        name        = port.value.name
        protocol    = port.value.protocol
        port        = port.value.port
        target_port = port.value.target_port
      }
    }
    selector = {
      "app.kubernetes.io/instance" = var.deployment_name
      "app.kubernetes.io/name"     = var.deployment_name
    }

    type = var.service_type
  }
}

