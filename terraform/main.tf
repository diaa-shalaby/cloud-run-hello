# Configure the Google Cloud provider
provider "google" {
  project = var.project_id
  region  = var.region
}

# Enable the GKE and Compute APIs
resource "google_project_service" "gke" {
  service = "container.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
  disable_on_destroy = false
}

# Create the GKE cluster
resource "google_container_cluster" "hello-app-cluster" {
  name     = "hello-app-cluster"
  location = var.region # Choose a region
  initial_node_count = 1 # Adjust as needed
  # Add more configuration options as needed
}

# # Create a GKE cluster
# resource "google_container_cluster" "primary" {
#   name     = "hello-app-cluster"
#   location = var.region
#
#   # Configure the node pool
#   node_pool {
#     name               = "default-pool"
#     initial_node_count = 1
#     node_config {
#       machine_type = "n1-standard-1"
#       oauth_scopes = [
#         "https://www.googleapis.com/auth/compute",
#         "https://www.googleapis.com/auth/devstorage.read_only",
#         "https://www.googleapis.com/auth/logging.write",
#         "https://www.googleapis.com/auth/monitoring",
#       ]
#     }
#   }
#
# }