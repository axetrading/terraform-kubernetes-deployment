resource "kubernetes_horizontal_pod_autoscaler_v2" "main" {
  count = var.enable_hpa && var.hpa_metrics != {} ? 1 : 0

  metadata {
    name      = var.deployment_name
    namespace = local.namespace

    labels = {
      app = var.deployment_name
    }
  }
  spec {
    min_replicas = var.min_replicas
    max_replicas = var.max_replicas

    scale_target_ref {
      kind = "Deployment"
      name = kubernetes_deployment.main.metadata[0].name
    }

    dynamic "metric" {
      for_each = var.hpa_metrics
      content {
        type = try(metric.value.type, "Resource")
        resource {
          name = try(metric.value.resource_name, "cpu")
          target {
            type                = try(metric.value.target_type, "Utilization")
            average_utilization = try(metric.value.target_average_utilization, 80)
          }
        }
      }
    }
  }
}