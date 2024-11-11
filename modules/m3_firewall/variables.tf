variable "project_id" {
  description = "The ID of the project in which to create the firewall rule."
  type        = string
}

variable "rule_name" {
  description = "The name of the firewall rule."
  type        = string
}

variable "network" {
  description = "The name of the network in which to create the firewall rule."
  type        = string
}

variable "direction" {
  description = "Direction of traffic to apply the firewall rule to (INGRESS or EGRESS)."
  type        = string
  default     = "INGRESS"
}

variable "priority" {
  description = "Priority of the firewall rule. Lower priority is evaluated first."
  type        = number
  default     = 1000
}

variable "allow_protocol" {
  description = "Protocol to allow, such as tcp, udp, icmp."
  type        = string
  default     = "tcp"
}

variable "allow_ports" {
  description = "List of ports to allow for the protocol."
  type        = list(string)
  default     = ["80", "443"]
}

variable "source_ranges" {
  description = "List of source CIDR ranges if direction is INGRESS."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "destination_ranges" {
  description = "List of destination CIDR ranges if direction is EGRESS."
  type        = list(string)
  default     = []
}

variable "target_tags" {
  description = "List of target tags to apply the rule to specific VM instances."
  type        = list(string)
  default     = []
}
