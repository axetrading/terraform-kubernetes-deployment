resource "kubernetes_deployment" "main" {
  metadata {
    name      = var.deployment_name
    namespace = local.namespace
  }

  spec {
    replicas = var.enable_hpa ? var.min_replicas : var.replicas_number

    selector {
      match_labels = {
        "app.kubernetes.io/instance" = var.deployment_name

        "app.kubernetes.io/name" = var.deployment_name
      }
    }

    template {
      metadata {
        labels = {
          "app.kubernetes.io/instance" = var.deployment_name

          "app.kubernetes.io/name" = var.deployment_name
        }
      }

      spec {
        container {
          name  = var.deployment_name
          image = "${var.image_repository}:${var.image_tag}"

          dynamic "port" {
            for_each = lookup(var.container, "ports", {})
            content {
              name           = port.value.name
              container_port = port.value.container_port
              protocol       = port.value.protocol
            }
          }

          dynamic "env" {
            for_each = local.env
            content {
              name  = env.value.name
              value = env.value.value
            }
          }

          dynamic "resources" {
            for_each = flatten([lookup(var.container, "resources", {})])
            content {
              requests = {
                cpu    = lookup(resources.value, "request_cpu", null)
                memory = lookup(resources.value, "request_memory", null)
              }
              limits = {
                cpu    = lookup(resources.value, "limit_cpu", null)
                memory = lookup(resources.value, "limit_memory", null)
              }
            }
          }

          dynamic "liveness_probe" {
            for_each = flatten([lookup(var.container, "liveness_probe", {})])
            content {
              dynamic "tcp_socket" {
                for_each = contains(keys(liveness_probe.value), "tcp_socket") ? [liveness_probe.value.tcp_socket] : []
                content {
                  port = tcp_socket.value.port
                }
              }

              initial_delay_seconds = lookup(liveness_probe.value, "initial_delay_seconds", 10)
              period_seconds        = lookup(liveness_probe.value, "period_seconds", 30)
              timeout_seconds       = lookup(liveness_probe.value, "timeout_seconds", null)
              success_threshold     = lookup(liveness_probe.value, "success_threshold", null)
              failure_threshold     = lookup(liveness_probe.value, "failure_threshold", null)
            }
          }
          dynamic "readiness_probe" {
            for_each = flatten([lookup(var.container, "readiness_probe", {})])
            content {
              dynamic "http_get" {
                for_each = contains(keys(readiness_probe.value), "http_get") ? [readiness_probe.value.http_get] : []
                content {
                  path   = http_get.value.path
                  port   = http_get.value.port
                  scheme = http_get.value.scheme
                }
              }

              initial_delay_seconds = lookup(readiness_probe.value, "initial_delay_seconds", null)
              period_seconds        = lookup(readiness_probe.value, "period_seconds", null)
              timeout_seconds       = lookup(readiness_probe.value, "timeout_seconds", null)
              success_threshold     = lookup(readiness_probe.value, "success_threshold", null)
              failure_threshold     = lookup(readiness_probe.value, "failure_threshold", null)
            }
          }
          image_pull_policy = var.image_pull_policy
        }

        restart_policy                   = var.restart_policy
        termination_grace_period_seconds = var.termination_grace_period_seconds
        dns_policy                       = var.dns_policy
        service_account_name             = local.service_account_name
      }
    }

    strategy {
      type = var.deployment_strategy

      dynamic "rolling_update" {
        for_each = flatten([var.rolling_update])
        content {
          max_unavailable = lookup(rolling_update.value, "max_unavailable", "25%")
          max_surge       = lookup(rolling_update.value, "max_surge", "25%")
        }
      }
    }

    revision_history_limit    = var.revision_history_limit
    progress_deadline_seconds = var.progress_deadline_seconds
  }
}
