# Persistent volumes
resource "openstack_blockstorage_volume_v2" "rancher-server-volume" {
  region      = "GRA1"
  name        = "rancher-server"
  description = "PROD - Rancher server volume"
  size        = 10
  volume_type = "high-speed"
}
resource "openstack_blockstorage_volume_v2" "internal-db-volume" {
  region      = "GRA1"
  name        = "internal-db"
  description = "PROD - Internal DB volume"
  size        = 10
  volume_type = "high-speed"
}
resource "openstack_blockstorage_volume_v2" "registry-volume" {
  region      = "GRA1"
  name        = "registry"
  description = "PROD - Internal registry volume"
  size        = 500
  volume_type = "high-speed"
}
resource "openstack_blockstorage_volume_v2" "registry-rescue-volume" {
  region      = "SBG1"
  name        = "registry-rescue"
  description = "PROD - Internal registry rescue volume"
  size        = 50
  volume_type = "high-speed"
}
resource "openstack_blockstorage_volume_v2" "registry-chal-volume" {
  region      = "GRA1"
  name        = "registry-chal"
  description = "PROD - Internal chal registry volume"
  size        = 50
  volume_type = "high-speed"
}
resource "openstack_blockstorage_volume_v2" "replica-01-volume" {
  region      = "GRA1"
  name        = "replica-01"
  description = "PROD - Replica 01 volume"
  size        = 20
  volume_type = "high-speed"
}
resource "openstack_blockstorage_volume_v2" "replica-02-volume" {
  region      = "GRA1"
  name        = "replica-02"
  description = "PROD - Replica 02 volume"
  size        = 20
  volume_type = "high-speed"
}
resource "openstack_blockstorage_volume_v2" "replica-03-volume" {
  region      = "SBG1"
  name        = "replica-03"
  description = "PROD - Replica 03 volume"
  size        = 20
  volume_type = "high-speed"
}

# Compute instances
resource "openstack_compute_instance_v2" "replica-01" {
  name            = "replica-01.infra.insecurity-insa.fr"
  image_id        = "${data.openstack_images_image_v2.debian-9.id}"
  flavor_id       = "${data.openstack_compute_flavor_v2.vps-ssd-2.id}"
  key_pair        = "${openstack_compute_keypair_v2.prod-keypair.name}"
  security_groups = ["default"]
  region          = "GRA1"

  network {
    name = "Ext-Net"
  }

  depends_on = ["openstack_compute_keypair_v2.prod-keypair"]
}
resource "openstack_compute_instance_v2" "replica-02" {
  name            = "replica-02.infra.insecurity-insa.fr"
  image_id        = "${data.openstack_images_image_v2.debian-9.id}"
  flavor_id       = "${data.openstack_compute_flavor_v2.vps-ssd-2.id}"
  key_pair        = "${openstack_compute_keypair_v2.prod-keypair.name}"
  security_groups = ["default"]
  region          = "GRA1"

  network {
    name = "Ext-Net"
  }

  depends_on = ["openstack_compute_keypair_v2.prod-keypair"]
}
resource "openstack_compute_instance_v2" "replica-03" {
  name            = "replica-03.infra.insecurity-insa.fr"
  image_id        = "${data.openstack_images_image_v2.debian-9-sbg.id}"
  flavor_id       = "${data.openstack_compute_flavor_v2.vps-ssd-2-sbg.id}"
  key_pair        = "${openstack_compute_keypair_v2.prod-keypair-sbg.name}"
  security_groups = ["default"]
  region          = "SBG1"

  network {
    name = "Ext-Net"
  }

  depends_on = ["openstack_compute_keypair_v2.prod-keypair-sbg"]
}
resource "openstack_compute_instance_v2" "rancher-server" {
  name            = "rancher.infra.insecurity-insa.fr"
  image_id        = "07c6c63d-4836-4a43-ac46-5c7108a63940"
  flavor_id       = "${data.openstack_compute_flavor_v2.eg-7-ssd.id}"
  key_pair        = "${openstack_compute_keypair_v2.prod-keypair.name}"
  security_groups = ["default"]
  region          = "GRA1"

  network {
    name = "Ext-Net"
  }

  depends_on = ["openstack_compute_keypair_v2.prod-keypair"]
}
resource "openstack_compute_instance_v2" "management" {
  name            = "mgmt.infra.insecurity-insa.fr"
  image_id        = "d44515bd-8d5a-47bc-bc17-23fa4c238548"
  flavor_id       = "${data.openstack_compute_flavor_v2.vps-ssd-1.id}"
  key_pair        = "${openstack_compute_keypair_v2.prod-keypair.name}"
  security_groups = ["default"]
  region          = "GRA1"

  network {
    name = "Ext-Net"
  }

  depends_on = ["openstack_compute_keypair_v2.prod-keypair"]
}
resource "openstack_compute_instance_v2" "registry" {
  name            = "registry.infra.insecurity-insa.fr"
  image_id        = "d44515bd-8d5a-47bc-bc17-23fa4c238548"
  flavor_id       = "${data.openstack_compute_flavor_v2.vps-ssd-2.id}"
  key_pair        = "${openstack_compute_keypair_v2.prod-keypair.name}"
  security_groups = ["default"]
  region          = "GRA1"

  network {
    name = "Ext-Net"
  }

  depends_on = ["openstack_compute_keypair_v2.prod-keypair"]
}
resource "openstack_compute_instance_v2" "registry-rescue" {
  name            = "registry.rescue.insecurity-insa.fr"
  image_id        = "${data.openstack_images_image_v2.debian-9-sbg.id}"
  flavor_id       = "${data.openstack_compute_flavor_v2.vps-ssd-1-sbg.id}"
  key_pair        = "${openstack_compute_keypair_v2.prod-keypair-sbg.name}"
  security_groups = ["default"]
  region          = "SBG1"

  network {
    name = "Ext-Net"
  }

  depends_on = ["openstack_compute_keypair_v2.prod-keypair-sbg"]
}
resource "openstack_compute_instance_v2" "registry-chal" {
  name            = "registry-chal.infra.insecurity-insa.fr"
  image_id        = "d44515bd-8d5a-47bc-bc17-23fa4c238548"
  flavor_id       = "${data.openstack_compute_flavor_v2.vps-ssd-1.id}"
  key_pair        = "${openstack_compute_keypair_v2.prod-keypair.name}"
  security_groups = ["default"]
  region          = "GRA1"

  network {
    name = "Ext-Net"
  }

  depends_on = ["openstack_compute_keypair_v2.prod-keypair"]
}
resource "openstack_compute_instance_v2" "internal-db-01" {
  name            = "internal-db-01.infra.insecurity-insa.fr"
  image_id        = "d44515bd-8d5a-47bc-bc17-23fa4c238548"
  flavor_id       = "${data.openstack_compute_flavor_v2.vps-ssd-1.id}"
  key_pair        = "${openstack_compute_keypair_v2.prod-keypair.name}"
  security_groups = ["default"]
  region          = "GRA1"

  network {
    name = "Ext-Net"
  }

  depends_on = ["openstack_compute_keypair_v2.prod-keypair"]
}
resource "openstack_compute_instance_v2" "internal-node" {
  count           = "${var.internal_node_count}"
  name            = "${format("internal-node-%02d.infra.insecurity-insa.fr", count.index + 1)}"
  image_id        = "d44515bd-8d5a-47bc-bc17-23fa4c238548"
  flavor_id       = "${data.openstack_compute_flavor_v2.vps-ssd-2.id}"
  key_pair        = "${openstack_compute_keypair_v2.prod-keypair.name}"
  security_groups = ["default"]
  region          = "GRA1"

  network {
    name = "Ext-Net"
  }

  depends_on = ["openstack_compute_keypair_v2.prod-keypair"]
}
resource "openstack_compute_instance_v2" "internal-node-rescue" {
  count           = "${var.internal_node_rescue_count}"
  name            = "${format("internal-node-%02d.rescue.insecurity-insa.fr", count.index + 1)}"
  image_id        = "${data.openstack_images_image_v2.debian-9-sbg.id}"
  flavor_id       = "${data.openstack_compute_flavor_v2.vps-ssd-2-sbg.id}"
  key_pair        = "${openstack_compute_keypair_v2.prod-keypair-sbg.name}"
  security_groups = ["default"]
  region          = "SBG1"

  network {
    name = "Ext-Net"
  }

  depends_on = ["openstack_compute_keypair_v2.prod-keypair-sbg"]
}
resource "openstack_compute_instance_v2" "privileged-node" {
  count           = "${var.privileged_node_count}"
  name            = "${format("privileged-node-%02d.infra.insecurity-insa.fr", count.index + 1)}"
  image_id        = "d44515bd-8d5a-47bc-bc17-23fa4c238548"
  flavor_id       = "${data.openstack_compute_flavor_v2.vps-ssd-3.id}"
  key_pair        = "${openstack_compute_keypair_v2.prod-keypair.name}"
  security_groups = ["default"]
  region          = "GRA1"

  network {
    name = "Ext-Net"
  }

  depends_on = ["openstack_compute_keypair_v2.prod-keypair"]
}
resource "openstack_compute_instance_v2" "privileged-node-rescue" {
  count           = "${var.privileged_node_rescue_count}"
  name            = "${format("privileged-node-%02d.rescue.insecurity-insa.fr", count.index + 1)}"
  image_id        = "${data.openstack_images_image_v2.debian-9-sbg.id}"
  flavor_id       = "${data.openstack_compute_flavor_v2.vps-ssd-1-sbg.id}"
  key_pair        = "${openstack_compute_keypair_v2.prod-keypair-sbg.name}"
  security_groups = ["default"]
  region          = "SBG1"

  network {
    name = "Ext-Net"
  }

  depends_on = ["openstack_compute_keypair_v2.prod-keypair-sbg"]
}
resource "openstack_compute_instance_v2" "chal-node" {
  count           = "${var.chal_node_count}"
  name            = "${format("chal-node-%02d.infra.insecurity-insa.fr", count.index + 1)}"
  image_id        = "d44515bd-8d5a-47bc-bc17-23fa4c238548"
  flavor_id       = "${data.openstack_compute_flavor_v2.vps-ssd-1.id}"
  key_pair        = "${openstack_compute_keypair_v2.prod-keypair.name}"
  security_groups = ["default"]
  region          = "GRA1"

  network {
    name = "Ext-Net"
  }

  depends_on = ["openstack_compute_keypair_v2.prod-keypair"]
}
resource "openstack_compute_instance_v2" "chal-node-rescue" {
  count           = "${var.chal_node_rescue_count}"
  name            = "${format("chal-node-%02d.rescue.insecurity-insa.fr", count.index + 1)}"
  image_id        = "${data.openstack_images_image_v2.debian-9-sbg.id}"
  flavor_id       = "${data.openstack_compute_flavor_v2.vps-ssd-1-sbg.id}"
  key_pair        = "${openstack_compute_keypair_v2.prod-keypair-sbg.name}"
  security_groups = ["default"]
  region          = "SBG1"

  network {
    name = "Ext-Net"
  }

  depends_on = ["openstack_compute_keypair_v2.prod-keypair-sbg"]
}


# Instances <-> volume links
resource "openstack_compute_volume_attach_v2" "rancher-master-volume-attach" {
  instance_id = "${openstack_compute_instance_v2.rancher-server.id}"
  volume_id   = "${openstack_blockstorage_volume_v2.rancher-server-volume.id}"
}
resource "openstack_compute_volume_attach_v2" "internal-db-01-volume-attach" {
  instance_id = "${openstack_compute_instance_v2.internal-db-01.id}"
  volume_id   = "${openstack_blockstorage_volume_v2.internal-db-volume.id}"
}
resource "openstack_compute_volume_attach_v2" "registry-volume-attach" {
  instance_id = "${openstack_compute_instance_v2.registry.id}"
  volume_id   = "${openstack_blockstorage_volume_v2.registry-volume.id}"
}
resource "openstack_compute_volume_attach_v2" "registry-chal-volume-attach" {
  instance_id = "${openstack_compute_instance_v2.registry-chal.id}"
  volume_id   = "${openstack_blockstorage_volume_v2.registry-chal-volume.id}"
}
resource "openstack_compute_volume_attach_v2" "registry-rescue-volume-attach" {
  instance_id = "${openstack_compute_instance_v2.registry-rescue.id}"
  volume_id   = "${openstack_blockstorage_volume_v2.registry-rescue-volume.id}"
  region      = "SBG1"
}
resource "openstack_compute_volume_attach_v2" "replica-01-volume-attach" {
  instance_id = "${openstack_compute_instance_v2.replica-01.id}"
  volume_id   = "${openstack_blockstorage_volume_v2.replica-01-volume.id}"
}
resource "openstack_compute_volume_attach_v2" "replica-02-volume-attach" {
  instance_id = "${openstack_compute_instance_v2.replica-02.id}"
  volume_id   = "${openstack_blockstorage_volume_v2.replica-02-volume.id}"
}
resource "openstack_compute_volume_attach_v2" "replica-03-volume-attach" {
  instance_id = "${openstack_compute_instance_v2.replica-03.id}"
  volume_id   = "${openstack_blockstorage_volume_v2.replica-03-volume.id}"
  region      = "SBG1"
}


# DNS configuration
resource "ovh_domain_zone_record" "dns-replica-01" {
  zone      = "insecurity-insa.fr"
  fieldtype = "A"
  subdomain = "replica-01.infra"
  target    = "${openstack_compute_instance_v2.replica-01.network.0.fixed_ip_v4}"
  ttl       = 120
  depends_on = ["openstack_compute_instance_v2.replica-01"]
}
resource "ovh_domain_zone_record" "dns-replica-02" {
  zone      = "insecurity-insa.fr"
  fieldtype = "A"
  subdomain = "replica-02.infra"
  target    = "${openstack_compute_instance_v2.replica-02.network.0.fixed_ip_v4}"
  ttl       = 120
  depends_on = ["openstack_compute_instance_v2.replica-02"]
}
resource "ovh_domain_zone_record" "dns-replica-03" {
  zone      = "insecurity-insa.fr"
  fieldtype = "A"
  subdomain = "replica-03.infra"
  target    = "${openstack_compute_instance_v2.replica-03.network.0.fixed_ip_v4}"
  ttl       = 120
  depends_on = ["openstack_compute_instance_v2.replica-03"]
}
resource "ovh_domain_zone_record" "dns-rancher-infra-insecurity-insa-fr" {
  zone      = "insecurity-insa.fr"
  fieldtype = "A"
  subdomain = "rancher.backup"
  target    = "${openstack_compute_instance_v2.rancher-server.network.0.fixed_ip_v4}"
  ttl       = 120
  depends_on = ["openstack_compute_instance_v2.rancher-server"]
}
resource "ovh_domain_zone_record" "dns-rancher-01" {
  zone      = "insecurity-insa.fr"
  fieldtype = "CNAME"
  subdomain = "rancher.infra"
  target    = "replica-01.infra"
  ttl       = 120
  depends_on = ["openstack_compute_instance_v2.replica-01"]
}
resource "ovh_domain_zone_record" "dns-rancher-02" {
  zone      = "insecurity-insa.fr"
  fieldtype = "CNAME"
  subdomain = "rancher.infra"
  target    = "replica-02.infra"
  ttl       = 120
  depends_on = ["openstack_compute_instance_v2.replica-02"]
}
resource "ovh_domain_zone_record" "dns-rancher-03" {
  zone      = "insecurity-insa.fr"
  fieldtype = "CNAME"
  subdomain = "rancher.infra"
  target    = "replica-03.infra"
  ttl       = 120
  depends_on = ["openstack_compute_instance_v2.replica-03"]
}
resource "ovh_domain_zone_record" "dns-management-infra-insecurity-insa-fr" {
  zone      = "insecurity-insa.fr"
  fieldtype = "A"
  subdomain = "mgmt.infra"
  target    = "${openstack_compute_instance_v2.management.network.0.fixed_ip_v4}"
  ttl       = 120
  depends_on = ["openstack_compute_instance_v2.management"]
}
resource "ovh_domain_zone_record" "dns-munin-infra-insecurity-insa-fr" {
  zone      = "insecurity-insa.fr"
  fieldtype = "CNAME"
  subdomain = "munin.infra"
  target    = "mgmt.infra"
  ttl       = 120
  depends_on = ["openstack_compute_instance_v2.management"]
}
resource "ovh_domain_zone_record" "dns-registry" {
  zone      = "insecurity-insa.fr"
  fieldtype = "A"
  subdomain = "registry.infra"
  target    = "${openstack_compute_instance_v2.registry.network.0.fixed_ip_v4}"
  ttl       = 120
  depends_on = ["openstack_compute_instance_v2.registry"]
}
resource "ovh_domain_zone_record" "dns-registry-chal" {
  zone      = "insecurity-insa.fr"
  fieldtype = "A"
  subdomain = "registry-chal.infra"
  target    = "${openstack_compute_instance_v2.registry-chal.network.0.fixed_ip_v4}"
  ttl       = 120
  depends_on = ["openstack_compute_instance_v2.registry-chal"]
}
resource "ovh_domain_zone_record" "dns-registry-rescue" {
  zone      = "insecurity-insa.fr"
  fieldtype = "A"
  subdomain = "registry.rescue"
  target    = "${openstack_compute_instance_v2.registry-rescue.network.0.fixed_ip_v4}"
  ttl       = 120
  depends_on = ["openstack_compute_instance_v2.registry-rescue"]
}
resource "ovh_domain_zone_record" "dns-internal-db-01-infra-insecurity-insa-fr" {
  zone      = "insecurity-insa.fr"
  fieldtype = "A"
  subdomain = "internal-db-01.infra"
  target    = "${openstack_compute_instance_v2.internal-db-01.network.0.fixed_ip_v4}"
  ttl       = 120
  depends_on = ["openstack_compute_instance_v2.internal-db-01"]
}
resource "ovh_domain_zone_record" "dns-internal-lb-01-infra-insecurity-insa-fr" {
  count     = "${var.internal_lb_count}"
  zone      = "insecurity-insa.fr"
  fieldtype = "CNAME"
  subdomain = "internal-lb.infra"
  target    = "${format("internal-node-%02d.infra", count.index + 1)}"
  ttl       = 120
}
resource "ovh_domain_zone_record" "dns-internal-node" {
  count     = "${var.internal_node_count}"
  zone      = "insecurity-insa.fr"
  fieldtype = "A"
  subdomain = "${format("internal-node-%02d.infra", count.index + 1)}"
  target    = "${element(openstack_compute_instance_v2.internal-node.*.network.0.fixed_ip_v4, count.index)}"
  ttl       = 120
  depends_on = ["openstack_compute_instance_v2.internal-node"]
}
resource "ovh_domain_zone_record" "dns-internal-node-rescue" {
  count     = "${var.internal_node_rescue_count}"
  zone      = "insecurity-insa.fr"
  fieldtype = "A"
  subdomain = "${format("internal-node-%02d.rescue", count.index + 1)}"
  target    = "${element(openstack_compute_instance_v2.internal-node-rescue.*.network.0.fixed_ip_v4, count.index)}"
  ttl       = 120
  depends_on = ["openstack_compute_instance_v2.internal-node-rescue"]
}
resource "ovh_domain_zone_record" "dns-privileged-node" {
  count     = "${var.privileged_node_count}"
  zone      = "insecurity-insa.fr"
  fieldtype = "A"
  subdomain = "${format("privileged-node-%02d.infra", count.index + 1)}"
  target    = "${element(openstack_compute_instance_v2.privileged-node.*.network.0.fixed_ip_v4, count.index)}"
  ttl       = 120
  depends_on = ["openstack_compute_instance_v2.privileged-node"]
}
resource "ovh_domain_zone_record" "dns-privileged-node-rescue" {
  count     = "${var.privileged_node_rescue_count}"
  zone      = "insecurity-insa.fr"
  fieldtype = "A"
  subdomain = "${format("privileged-node-%02d.rescue", count.index + 1)}"
  target    = "${element(openstack_compute_instance_v2.privileged-node-rescue.*.network.0.fixed_ip_v4, count.index)}"
  ttl       = 120
  depends_on = ["openstack_compute_instance_v2.privileged-node-rescue"]
}
# resource "ovh_domain_zone_record" "dns-privileged-lb" {
#   count     = "${var.privileged_node_count}"
#   zone      = "insecurity-insa.fr"
#   fieldtype = "CNAME"
#   subdomain = "privileged-lb.infra"
#   target    = "${format("privileged-node-%02d.infra", count.index + 1)}"
#   ttl       = 120
# }
resource "ovh_domain_zone_record" "dns-chal-node" {
  count     = "${var.chal_node_count}"
  zone      = "insecurity-insa.fr"
  fieldtype = "A"
  subdomain = "${format("chal-node-%02d.infra", count.index + 1)}"
  target    = "${element(openstack_compute_instance_v2.chal-node.*.network.0.fixed_ip_v4, count.index)}"
  ttl       = 120
  depends_on = ["openstack_compute_instance_v2.chal-node"]
}
resource "ovh_domain_zone_record" "dns-chal-node-rescue" {
  count     = "${var.chal_node_rescue_count}"
  zone      = "insecurity-insa.fr"
  fieldtype = "A"
  subdomain = "${format("chal-node-%02d.rescue", count.index + 1)}"
  target    = "${element(openstack_compute_instance_v2.chal-node-rescue.*.network.0.fixed_ip_v4, count.index)}"
  ttl       = 120
  depends_on = ["openstack_compute_instance_v2.chal-node-rescue"]
}
#resource "ovh_domain_zone_record" "dns-chal-lb" {
#   count     = "${var.chal_node_count}"
#   zone      = "insecurity-insa.fr"
#   fieldtype = "CNAME"
#   subdomain = "chal-lb.infra"
#   target    = "${format("chal-node-%02d.infra", count.index + 1)}"
#   ttl       = 120
# }
