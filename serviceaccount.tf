resource "kubernetes_service_account" "main" {
  count = var.create_service_account ? 1 : 0
  metadata {
    name      = var.deployment_name
    namespace = local.namespace
  }
}

