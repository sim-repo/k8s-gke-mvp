
variable project {
    description = "GCP project ID"
    type        = string
    default     = "alpine-realm-270323"
}

variable region {
    description = "GCP region"
    type        = string
    default     = "us-east1"
}

variable name {
    description = "Environment name"
    type        = string
    default     = "production-188223"
}

variable node_pool_autoscaling_min_node_count {
    description = "Minimum nodes in cluster = value * availability zones count"
    type        = number
    default     = 2
}

variable node_pool_autoscaling_max_node_count {
    description = "Maximum nodes in cluster = value * availability zones count"
    type        = number
    default     = 3
}

variable worker_machine_type {
    description = "Worker node's machine type"
    type        = string
    default     = "n1-standard-2"
}


variable worker_disk_size {
  description = "Boot disk size (GB) for worker nodes"
  type        = number
  default     = 20
}

