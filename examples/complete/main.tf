module "deployment" {
  source           = "./deployment"
  deployment_name  = "test" #workspace-reponame
  namespace        = "test" # environ name
  image_repository = "nginx"
  image_tag        = "1.14.2" #worflow number - github.sha (first 7-8 chars)

  container = {
    env = {
      test  = "test"
      test2 = "test2"
    }
    ports = {
      apport = {
        name           = "appport"
        container_port = 80
        protocol       = "TCP"
      },
      adminport = {
        name           = "adminport"
        container_port = 81
        protocol       = "TCP"
      }
    }
    liveness_probe = { ### create a module for different Java / GO / etc 
      tcp_socket = {
        port = 80
      }
      failure_threshold     = 3
      initial_delay_seconds = 10
      period_seconds        = 30
      success_threshold     = 1
      timeout_seconds       = 3
    }
    readiness_probe = {
      http_get = {
        path   = "/actuator/healthcheck"
        port   = 81
        scheme = "HTTP"
      }
      failure_threshold     = 3
      initial_delay_seconds = 10
      period_seconds        = 30
      success_threshold     = 1
      timeout_seconds       = 3
    }
    resources = {
      request_cpu    = "100m"
      request_memory = "512Mi"
      limit_cpu      = "1"
      limit_memory   = "1024Mi"
    }
  }
  service = {
    appport = {
      protocol    = "TCP"
      port        = 80
      target_port = 80
    },
    adminport = {
      protocol    = "TCP"
      port        = 81
      target_port = "adminport"
    }
  }
  hpa_metrics = {
    cpu = {
      type                       = "Resource"
      resource_name              = "cpu"
      target_type                = "Utilization"
      target_average_utilization = 75
    }
    memory = {
      type                       = "Resource"
      resource_name              = "memory"
      target_type                = "Utilization"
      target_average_utilization = 75
    }
  }

  ingress_rules = {
    dev = {
      host      = "test.nginx.net"
      path      = "/"
      path_type = "Prefix"
      port      = 80
    }
  }
}
