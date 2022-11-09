# terraform-kubernetes-deployment
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.15.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.15.0 |

## Resources

| Name | Type |
|------|------|
| [kubernetes_deployment.main](https://registry.terraform.io/providers/hashicorp/kubernetes/2.15.0/docs/resources/deployment) | resource |
| [kubernetes_horizontal_pod_autoscaler_v2.main](https://registry.terraform.io/providers/hashicorp/kubernetes/2.15.0/docs/resources/horizontal_pod_autoscaler_v2) | resource |
| [kubernetes_ingress_v1.main](https://registry.terraform.io/providers/hashicorp/kubernetes/2.15.0/docs/resources/ingress_v1) | resource |
| [kubernetes_namespace.this](https://registry.terraform.io/providers/hashicorp/kubernetes/2.15.0/docs/resources/namespace) | resource |
| [kubernetes_service.main](https://registry.terraform.io/providers/hashicorp/kubernetes/2.15.0/docs/resources/service) | resource |
| [kubernetes_service_account.main](https://registry.terraform.io/providers/hashicorp/kubernetes/2.15.0/docs/resources/service_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container"></a> [container](#input\_container) | Pod's container configuration | `any` | `{}` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Wheter to create or not the namespace | `bool` | `false` | no |
| <a name="input_create_service_account"></a> [create\_service\_account](#input\_create\_service\_account) | Whether to create or not a Kubernetes Service Account for EKS Deployments | `bool` | `true` | no |
| <a name="input_deployment_name"></a> [deployment\_name](#input\_deployment\_name) | Kubernetes deployment name. | `string` | n/a | yes |
| <a name="input_deployment_strategy"></a> [deployment\_strategy](#input\_deployment\_strategy) | Type of deployment. Can be 'Recreate' or 'RollingUpdate'. Default is RollingUpdate. | `string` | `"RollingUpdate"` | no |
| <a name="input_dns_policy"></a> [dns\_policy](#input\_dns\_policy) | Set DNS policy for containers within the pod. Valid values are 'ClusterFirstWithHostNet', 'ClusterFirst', 'Default' or 'None'. | `string` | `"ClusterFirst"` | no |
| <a name="input_enable_hpa"></a> [enable\_hpa](#input\_enable\_hpa) | Whether to enable the creation of Kubernetes Horizontal Pod Autoscaler V2 | `bool` | `true` | no |
| <a name="input_enable_ingress"></a> [enable\_ingress](#input\_enable\_ingress) | Enable Kubernetes ingress for a specific service | `bool` | `true` | no |
| <a name="input_hpa_metrics"></a> [hpa\_metrics](#input\_hpa\_metrics) | Configuration of horizontal pod autoscaler | `any` | `{}` | no |
| <a name="input_image_pull_policy"></a> [image\_pull\_policy](#input\_image\_pull\_policy) | Image pull policy. One of Always, Never, IfNotPresent. | `string` | `"IfNotPresent"` | no |
| <a name="input_image_repository"></a> [image\_repository](#input\_image\_repository) | ECR Image Repository | `string` | n/a | yes |
| <a name="input_image_tag"></a> [image\_tag](#input\_image\_tag) | ECR Image tag | `string` | n/a | yes |
| <a name="input_ingress_rules"></a> [ingress\_rules](#input\_ingress\_rules) | Kubernetes ingress configuration for this deployment | `any` | `{}` | no |
| <a name="input_max_replicas"></a> [max\_replicas](#input\_max\_replicas) | Maximum number of replicas that will be created by HPA | `number` | `1` | no |
| <a name="input_min_replicas"></a> [min\_replicas](#input\_min\_replicas) | Minimum number of replicas that will be created by HPA | `number` | `1` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Kubernetes Namespace name. Defaults to default namespace | `string` | `"default"` | no |
| <a name="input_progress_deadline_seconds"></a> [progress\_deadline\_seconds](#input\_progress\_deadline\_seconds) | The maximum time in seconds for a deployment to make progress before it is considered to be failed. | `number` | `600` | no |
| <a name="input_replicas_number"></a> [replicas\_number](#input\_replicas\_number) | If the HPA is not enabled, this variable is setting the number of active replicas for each deployment. | `number` | `1` | no |
| <a name="input_restart_policy"></a> [restart\_policy](#input\_restart\_policy) | Restart policy for all containers within the pod. One of Always, OnFailure, Never. | `string` | `"Always"` | no |
| <a name="input_revision_history_limit"></a> [revision\_history\_limit](#input\_revision\_history\_limit) | The number of old ReplicaSets to retain to allow rollback. This is a pointer to distinguish between explicit zero and not specified. | `number` | `10` | no |
| <a name="input_rolling_update"></a> [rolling\_update](#input\_rolling\_update) | Rolling update config params. Present only if type = RollingUpdate. | `map(any)` | `{}` | no |
| <a name="input_service"></a> [service](#input\_service) | Kubernetes SVC configuration | `any` | `{}` | no |
| <a name="input_service_type"></a> [service\_type](#input\_service\_type) | Determines how the service is exposed. Defaults to ClusterIP. Valid options are ExternalName, ClusterIP, NodePort, and LoadBalancer | `string` | `"ClusterIP"` | no |
| <a name="input_termination_grace_period_seconds"></a> [termination\_grace\_period\_seconds](#input\_termination\_grace\_period\_seconds) | Duration in seconds the pod needs to terminate gracefully | `number` | `30` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kubernetes_deployment_name"></a> [kubernetes\_deployment\_name](#output\_kubernetes\_deployment\_name) | n/a |
| <a name="output_kubernetes_ingress_host"></a> [kubernetes\_ingress\_host](#output\_kubernetes\_ingress\_host) | n/a |
| <a name="output_kubernetes_ingress_id"></a> [kubernetes\_ingress\_id](#output\_kubernetes\_ingress\_id) | n/a |
| <a name="output_kubernetes_readiness_probe"></a> [kubernetes\_readiness\_probe](#output\_kubernetes\_readiness\_probe) | n/a |
| <a name="output_kubernetes_service_account_name"></a> [kubernetes\_service\_account\_name](#output\_kubernetes\_service\_account\_name) | n/a |
| <a name="output_kubernetes_service_id"></a> [kubernetes\_service\_id](#output\_kubernetes\_service\_id) | n/a |
| <a name="output_kubernetes_service_name"></a> [kubernetes\_service\_name](#output\_kubernetes\_service\_name) | K8S Service Name |
<!-- END_TF_DOCS -->