
# ---------------------------------------

variable "dc_network_name" {
  default = "network"
}

variable "dc_subnetwork_name" {
  default = "subnetwork"
}

variable "dc_ip_cidr_range" {
  type = "string"
  default = "10.0.0.0/16"
}

variable "cloud_ip_cidr_range" {
  type = "string"
  default = "10.10.0.0/16"
}

variable "caltech_ip_cidr_range" {
    default = "131.215.0.0/16"
}

variable "nfs_name" {
  default = "nfs"
}

variable "dc_fw_allow_ssh_name" {
  default = "allow-ssh"
}

# --------------------------------------
#  Resources
# --------------------------------------

# -----------------------
#  Network
# -----------------------

resource "google_compute_network" "dc_network" {
  name = "${var.dc_project_name}-${var.dc_network_name}"
  project = "${google_project.dc_project.id}"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "dc_subnetwork" {
  name = "${var.dc_project_name}-${var.dc_subnetwork_name}"
  project = "${google_project.dc_project.id}"
  ip_cidr_range = "${var.dc_ip_cidr_range}"
  region = "us-west1"
  network = "${google_compute_network.dc_network.name}"
  enable_flow_logs = true
  depends_on = ["google_compute_network.dc_network"]
}

resource "google_compute_network" "cloud_network" {
  name = "${var.cloud_project_name}-${var.dc_network_name}"
  project = "${google_project.cloud_project.id}"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "cloud_subnetwork" {
  name = "${var.cloud_project_name}-${var.dc_subnetwork_name}"
  project = "${google_project.cloud_project.id}"
  ip_cidr_range = "${var.cloud_ip_cidr_range}"
  region = "us-west1"
  network = "${google_compute_network.cloud_network.name}"
  enable_flow_logs = true
  depends_on = ["google_compute_network.cloud_network"]
}

# -----------------------------------------
#  Firewall
# -----------------------------------------
# -----------------------
#  Slurm DC
# -----------------------

resource "google_compute_firewall" "slurm_dc_fw_nfs" {
  name = "${var.dc_project_name}-${var.nfs_name}"
  project = "${google_project.dc_project.id}"
  network = "${google_compute_network.dc_network.id}"

  allow {
    protocol = "TCP"
    ports = ["2049","1110","4045"]
  }
  allow {
    protocol = "UDP"
    ports = ["2049","1110","4045"]
  }

  source_ranges = ["${var.cloud_ip_cidr_range}","${var.dc_ip_cidr_range}"]
  target_tags = ["controller"]
}

resource "google_compute_firewall" "slurm_dc_fw_slurmd" {
  name = "slurmd"
  project = "${google_project.dc_project.id}"
  network = "${google_compute_network.dc_network.id}"

  allow {
    protocol = "TCP"
    ports = ["6819-6830"]
  }


  source_ranges = ["${var.cloud_ip_cidr_range}","${var.dc_ip_cidr_range}"]
  target_tags = ["controller"]
}

resource "google_compute_firewall" "slurm_dc_fw_ssh" {
  name = "${var.dc_project_name}-${var.dc_fw_allow_ssh_name}"
  project = "${google_project.dc_project.id}"
  network = "${google_compute_network.dc_network.id}"

  allow {
    protocol = "TCP"
    ports = ["22"]
  }

  source_ranges = ["${var.caltech_ip_cidr_range}"]
}

# ------------------------
#  Slurm Cloud
# ------------------------

resource "google_compute_firewall" "slurm_cloud_fw_slurmd" {
  name = "${var.nfs_name}"
  project = "${google_project.cloud_project.id}"
  network = "${google_compute_network.cloud_network.id}"

  allow {
    protocol = "TCP"
    ports = ["6818"]
  }

  source_ranges = ["${var.dc_ip_cidr_range}"]
  target_tags = ["compute"]

}

# -----------------------------------------
#  Output
# -----------------------------------------

output "dc_network_name" {
  value = "${google_compute_network.dc_network.name}"
}

output "dc_subnetwork_name" {
  value = "${google_compute_subnetwork.dc_subnetwork.name}"
}

output "dc_network_self_link" {
  value = "${google_compute_network.dc_network.self_link}"
}

output "dc_subnetwork_self_link" {
  value = "${google_compute_subnetwork.dc_subnetwork.self_link}"
}

output "cloud_network_name" {
  value = "${google_compute_network.cloud_network.name}"
}
output "cloud_subnetwork_name" {
  value = "${google_compute_subnetwork.cloud_subnetwork.name}"
}

output "cloud_network_self_link" {
  value = "${google_compute_network.cloud_network.self_link}"
}

output "cloud_subnetwork_self_link" {
  value = "${google_compute_subnetwork.cloud_subnetwork.self_link}"
}
