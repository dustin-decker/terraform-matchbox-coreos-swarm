// Create a CoreOS-install profile
resource "matchbox_profile" "coreos-install" {
  name   = "coreos-install"
  kernel = "http://stable.release.core-os.net/amd64-usr/current/coreos_production_pxe.vmlinuz"

  initrd = [
    "http://stable.release.core-os.net/amd64-usr/current/coreos_production_pxe_image.cpio.gz",
  ]
  
  args = [
    "initrd=coreos_production_pxe_image.cpio.gz",
    "coreos.config.url=${var.matchbox_http_endpoint}/ignition?uuid=$${uuid}&mac=$${mac:hexhyp}",
    "coreos.first_boot=yes",
    "console=tty0",
    "console=ttyS0",
  ]

  container_linux_config = "${file("./cl/coreos-install.tmpl.yaml")}"
}

// Create a profile which has our running server config
resource "matchbox_profile" "core-node" {
  name                   = "core-node"
  container_linux_config = "${file("./cl/core-node.tmpl.yaml")}"
}