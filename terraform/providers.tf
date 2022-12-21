terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
    }
  }
}

provider "openstack" {
  user_name   = var.user_name
  password    = var.password
  tenant_name = var.project_name
  auth_url    = local.kis_os_auth_url
  region      = local.kis_os_region
  insecure    = true
  endpoint_overrides = local.kis_os_endpoint_overrides
}
