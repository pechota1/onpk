output "ssh_command" {
  value = "ssh -i ${abspath(".")}/${local_file.private_key.filename} ${local.image.ubuntu.os_username}@${openstack_compute_instance_v2.instance.access_ip_v4}"
}