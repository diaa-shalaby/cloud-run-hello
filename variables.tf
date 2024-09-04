variable "project_id" {
  type = string
  description = "The project ID for my GCP Cloud-pilots Interview"
  default = "cloudpilotsinterview"
}

variable "region" {
  type = string
  description = "The region to deploy your cluster"
  default = "us-central1"
}