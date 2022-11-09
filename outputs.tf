output "kubernetes_deployment_name" {
  value = kubernetes_deployment.main.metadata[0].name
}
output "kubernetes_readiness_probe" {
  value = flatten(kubernetes_deployment.main.spec[*].template[*].spec[*].container[*].readiness_probe[*].http_get[*].path)
}

output "kubernetes_service_id" {
  value = try(kubernetes_service.main.id, "")
}

# K8S Service Name
output "kubernetes_service_name" {
  value = kubernetes_service.main.metadata[0].name
}
output "kubernetes_ingress_id" {
  value = try(kubernetes_ingress_v1.main[0].id, "")
}

output "kubernetes_ingress_host" {
  value = try(flatten(kubernetes_ingress_v1.main[0].spec[*].rule[*].host), "")
}

output "kubernetes_service_account_name" {
  value = try(kubernetes_service_account.main[0].metadata[0].name)
}