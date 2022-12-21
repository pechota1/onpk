variable "project_name" {
  type = string
}

variable "environment" {
  type = string
  default = "dev"
}

variable "user_name" {
    type = string
}

variable "password" {
    type = string
}

variable "ip_protocol" {
  type = string
  default = "tcp"
}

variable "network_name" {
  type    = string
  default = "ext-net"
}