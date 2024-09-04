# Configure the Google Cloud provider
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

# Configure Google Cloud project and region
provider "google" {
  project = var.project_id
  region  = var.region
}

# Create a GKE cluster
resource "google_container_cluster" "primary" {
  name     = "cp-cluster"
  location = var.region

  # Configure node pools
  node_pool {
    name               = "default-pool"
    initial_node_count = 1
    # Configure machine type, disk size, etc.
  }
}

# Create a Kubernetes Deployment
resource "kubernetes_deployment" "app_deployment" {
  metadata {
    name = "my-hello-app"
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "my-hello-app"
      }
    }
    template {
      metadata {
        labels = {
          app = "my-hello-app"
        }
      }
      spec {
        containers {
          name  = "my-hello-app-container"
          image = "us-docker.pkg.dev/cloudrun/container/hello"

          # Expose container port
          port {
            container_port = 8080
          }
        }
      }
    }
  }
}

# Create a Kubernetes Service
resource "kubernetes_service" "app_service" {
  metadata {
    name = "my-hello-app-service"
  }
  spec {
    selector = {
      app = "my-hello-app"
    }
    port {
      port       = 80
      target_port = 8080
    }
    type = "LoadBalancer"
  }
}

# Output the public IP address of the load balancer
output "load_balancer_ip" {
  value = google_container_cluster.primary.endpoint
}