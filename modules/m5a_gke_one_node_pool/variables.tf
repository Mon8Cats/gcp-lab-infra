variable "project_id" {
  description = "The ID of the project in which to create the GKE cluster."
  type        = string
}

variable "region" {
  description = "The region to deploy the GKE cluster."
  type        = string
  default     = "us-central1"
}

variable "cluster_name" {
  description = "The name of the GKE cluster."
  type        = string
}

variable "node_count" {
  description = "The number of nodes in the node pool."
  type        = number
  default     = 3
}

variable "machine_type" {
  description = "The type of machine to use for nodes."
  type        = string
  default     = "e2-medium"
}

variable "network" {
  description = "The VPC network to attach to the cluster."
  type        = string
}

variable "subnetwork" {
  description = "The subnet to attach to the cluster."
  type        = string
}

variable "node_locations" {
  description = "The zones in which nodes should be created."
  type        = list(string)
  default     = ["us-central1-a", "us-central1-b", "us-central1-c"]
}

variable "preemptible" {
  description = "Whether the nodes are preemptible."
  type        = bool
  default     = false
}

variable "min_node_count" {
  description = "Minimum number of nodes in the node pool for autoscaling."
  type        = number
  default     = 1
}

variable "max_node_count" {
  description = "Maximum number of nodes in the node pool for autoscaling."
  type        = number
  default     = 5
}

variable "node_tags" {
  description = "Network tags for the nodes in the cluster."
  type        = list(string)
  default     = ["gke-node"]
}

variable "master_authorized_network" {
  description = "CIDR block for accessing the Kubernetes master."
  type        = string
  default     = "0.0.0.0/0"
}
