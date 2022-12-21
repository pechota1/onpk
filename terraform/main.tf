resource "openstack_compute_keypair_v2" "keypair" {
  name = "${var.project_name}-${var.environment}-keypair"
}

resource "local_file" "private_key" {
  content         = openstack_compute_keypair_v2.keypair.private_key
  filename        = "${path.module}/${openstack_compute_keypair_v2.keypair.name}.pem"
  file_permission = "0400"
}

resource "openstack_networking_secgroup_v2" "security_group" {
  name = "${var.project_name}-${var.environment}-secgroup"
}

data "http" "my_public_ip" {
  url = "http://ipv4.icanhazip.com"
}

# Allow ICMP from your public IP address
resource "openstack_networking_secgroup_rule_v2" "security_group_rule_icmp" {
  description       = "Managed by Terraform!"
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = join("/", [local.my_public_ip, "32"])
  security_group_id = openstack_networking_secgroup_v2.security_group.id
}

# Allow UDP from your public IP address
resource "openstack_networking_secgroup_rule_v2" "security_group_rule_udp" {
  description       = "Managed by Terraform!"
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "udp"
  remote_ip_prefix  = join("/", [local.my_public_ip, "32"])
  security_group_id = openstack_networking_secgroup_v2.security_group.id
}

# Allow ALL TCP from your public IP address
resource "openstack_networking_secgroup_rule_v2" "security_group_rule_tcp" {
  description       = "Managed by Terraform!"
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  remote_ip_prefix  = join("/", [local.my_public_ip, "32"])
  security_group_id = openstack_networking_secgroup_v2.security_group.id
}

data "cloudinit_config" "user_data" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    filename     = "userdata_base"
    content      = file("${path.module}/scripts/base.sh")
  }

  part {
    content_type = "text/x-shellscript"
    filename     = "userdata_docker"
    content      = file("${path.module}/scripts/docker.sh")
  }

  part {
    content_type = "text/x-shellscript"
    filename     = "userdata_minikube"
    content      = file("${path.module}/scripts/minikube.sh")
  }
}

resource "openstack_compute_instance_v2" "instance" {
  name            = "${var.project_name}-${var.environment}-instance"
  image_id        = local.image.ubuntu.id
  flavor_id       = local.flavor.onpk_large.id
  key_pair        = openstack_compute_keypair_v2.keypair.name
  security_groups = [openstack_networking_secgroup_v2.security_group.name]

  user_data = data.cloudinit_config.user_data.rendered

  network {
    name = var.network_name
  }
}