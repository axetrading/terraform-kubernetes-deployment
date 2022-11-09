variable "deployment_name" {
  type        = string
  description = "Kubernetes deployment name."
}

variable "create_namespace" {
  type        = bool
  description = "Wheter to create or not the namespace"
  default     = false
}

variable "namespace" {
  type        = string
  description = "Kubernetes Namespace name. Defaults to default namespace"
  default     = "default"
}

variable "image_repository" {
  type        = string
  description = "ECR Image Repository"
}

variable "image_tag" {
  type        = string
  description = "ECR Image tag"
}

variable "min_replicas" {
  type        = number
  description = "Minimum number of replicas that will be created by HPA"
  default     = 1
}

variable "max_replicas" {
  type        = number
  description = "Maximum number of replicas that will be created by HPA"
  default     = 1
}

variable "hpa_metrics" {
  description = "Configuration of horizontal pod autoscaler"
  type        = any
  default     = {}
}

variable "enable_hpa" {
  type        = bool
  description = "Whether to enable the creation of Kubernetes Horizontal Pod Autoscaler V2"
  default     = true
}

variable "replicas_number" {
  type        = number
  description = "If the HPA is not enabled, this variable is setting the number of active replicas for each deployment."
  default     = 1
}

variable "container" {
  type        = any
  description = "Pod's container configuration"
  default     = {}
}

variable "image_pull_policy" {
  type        = string
  description = "Image pull policy. One of Always, Never, IfNotPresent."
  default     = "IfNotPresent"
}

variable "restart_policy" {
  type        = string
  description = "Restart policy for all containers within the pod. One of Always, OnFailure, Never."
  default     = "Always"
}

variable "termination_grace_period_seconds" {
  description = "Duration in seconds the pod needs to terminate gracefully"
  default     = 30
  type        = number
}

variable "dns_policy" {
  type        = string
  description = "Set DNS policy for containers within the pod. Valid values are 'ClusterFirstWithHostNet', 'ClusterFirst', 'Default' or 'None'."
  default     = "ClusterFirst"
}

variable "deployment_strategy" {
  type        = string
  description = "Type of deployment. Can be 'Recreate' or 'RollingUpdate'. Default is RollingUpdate."
  default     = "RollingUpdate"
}
variable "rolling_update" {
  type        = map(any)
  description = "Rolling update config params. Present only if type = RollingUpdate."
  default     = {}
}

variable "revision_history_limit" {
  type        = number
  description = "The number of old ReplicaSets to retain to allow rollback. This is a pointer to distinguish between explicit zero and not specified."
  default     = 10
}

variable "progress_deadline_seconds" {
  type        = number
  description = "The maximum time in seconds for a deployment to make progress before it is considered to be failed."
  default     = 600
}

variable "create_service_account" {
  type        = bool
  default     = true
  description = "Whether to create or not a Kubernetes Service Account for EKS Deployments"
}

variable "service" {
  type        = any
  default     = {}
  description = "Kubernetes SVC configuration"
}

variable "service_type" {
  type        = string
  description = "Determines how the service is exposed. Defaults to ClusterIP. Valid options are ExternalName, ClusterIP, NodePort, and LoadBalancer"
  default     = "ClusterIP"
}

variable "enable_ingress" {
  type        = bool
  description = "Enable Kubernetes ingress for a specific service"
  default     = true
}

variable "ingress_rules" {
  type        = any
  description = "Kubernetes ingress configuration for this deployment"
  default     = {}
}