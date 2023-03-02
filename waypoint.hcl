project = "waypoint-demo"

app "waypoint-demo" {
  labels = {
    "service" = "waypoint-demo"
    "env"     = "playpen"
  }

  build {
    use "pack" {}

    registry {
      use "docker" {
        image = "maxtroughear/waypoint-demo"
        tag   = gitrefpretty()
        local = true
        auth {
          username = var.registry_username
          password = var.registry_password
        }
      }
    }
  }

  deploy {
    use "kubernetes" {
      probe_path   = "/"
      service_port = 8080
    }
  }

  release {
    use "kubernetes" {
      load_balancer = true
    }
  }
}

variable "registry_username" {
  default     = "username"
  type        = string
  sensitive   = true
  description = "username for container registry"
}

variable "registry_password" {
  default     = "password"
  type        = string
  sensitive   = true
  description = "password for registry"
}
