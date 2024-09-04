# Configure the Google Cloud provider
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

# Enable the required Google Cloud APIs
resource "google_project_service" "gke_api" {
  service            = "container.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "compute_api" {
  service            = "compute.googleapis.com"
  disable_on_destroy = false
}

# Create a GKE cluster
resource "google_container_cluster" "primary" {
  name     = "hello-app-cluster"
  location = var.region

  # Configure the node pool
  node_pool {
    name               = "default-pool"
    initial_node_count = 1
    node_config {
      machine_type = "n1-standard-1"
      oauth_scopes = [
        "https://www.googleapis.com/auth/compute",
        "https://www.googleapis.com/auth/devstorage.read_only",
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/monitoring",
      ]
    }
  }

}