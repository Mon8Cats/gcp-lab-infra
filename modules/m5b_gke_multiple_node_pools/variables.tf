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

variable "network" {
  description = "The VPC network to attach to the cluster."
  type        = string
}

variable "node_locations" {
  description = "The zones in which nodes should be created."
  type        = list(string)
  default     = ["us-central1-a", "us-central1-b", "us-central1-c"]
}

# Define node pool configurations with subnets
variable "node_pools" {
  description = "List of node pools, each with its own settings and subnet."
  type = list(object({
    name            = string
    machine_type    = string
    subnetwork      = string
    node_count      = number
    min_node_count  = number
    max_node_count  = number
    node_tags       = list(string)
  }))
  default = [
    {
      name            = "pool-1"
      machine_type    = "e2-medium"
      subnetwork      = "subnet-1"
      node_count      = 3
      min_node_count  = 1
      max_node_count  = 5
      node_tags       = ["gke-node", "subnet-1"]
    },
    {
      name            = "pool-2"
      machine_type    = "e2-medium"
      subnetwork      = "subnet-2"
      node_count      = 3
      min_node_count  = 1
      max_node_count  = 5
      node_tags       = ["gke-node", "subnet-2"]
    }
  ]
}
