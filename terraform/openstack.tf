data "openstack_compute_flavor_v2" "vps-ssd-1" {
  vcpus  = 1
  ram    = 2000
  region = "GRA1"
}

data "openstack_compute_flavor_v2" "vps-ssd-2" {
  vcpus = 1
  ram   = 4000
  region = "GRA1"
}

data "openstack_compute_flavor_v2" "vps-ssd-3" {
  vcpus = 2
  ram   = 8000
  region = "GRA1"
}

data "openstack_compute_flavor_v2" "vps-ssd-1-sbg" {
  vcpus  = 1
  ram    = 2000
  region = "SBG1"
}

data "openstack_compute_flavor_v2" "vps-ssd-2-sbg" {
  vcpus = 1
  ram   = 4000
  region = "SBG1"
}

data "openstack_compute_flavor_v2" "vps-ssd-3-sbg" {
  vcpus = 2
  ram   = 8000
  region = "SBG1"
}

data "openstack_compute_flavor_v2" "eg-7-ssd" {
  name  = "eg-7-ssd"
  vcpus = 2
  ram   = 7000
  region = "GRA1"
}

data "openstack_images_image_v2" "debian-9" {
  name = "Debian 9"
  most_recent = true
  region = "GRA1"
}

data "openstack_images_image_v2" "debian-9-sbg" {
  name = "Debian 9"
  most_recent = true
  region = "SBG1"
}
