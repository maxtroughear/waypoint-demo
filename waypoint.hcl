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
        image = "waypoint-demo"
        tag   = gitrefpretty()
        local = true
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
