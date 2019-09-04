# --------------------------------------
#       Variables
# --------------------------------------
variable "org_id" {
  default = "482676055061"
}

variable "billing_account" {
  default = "01A7C1-F7ECC5-A7181E"
}

variable "folder_name" {
  #default = "slurm-test"
  default = "43538224038"
}

variable "random_id" {
        default = 2
}

variable "dc_project_name" {
        default = "slurm-dc2"
}

variable "cloud_project_name" {
        default = "slurm-cloud2"
}

variable "auto_create_network" {
  default = false
}

# --------------------------------------
#       Resources
# -------------------------------------

# ---------------------
#       Folder
# ---------------------
/*
resource "google_folder" "folder" {
  display_name = "${var.folder_name}"
  parent = "organizations/${var.org_id}"
}
*/
# --------------------
#       Random ID(s)
# --------------------

resource "random_id" "dc_id" {
        byte_length = "${var.random_id}"
        prefix = "${var.dc_project_name}-"
}

resource "random_id" "cloud_id" {
        byte_length = "${var.random_id}"
        prefix = "${var.cloud_project_name}-"
}

# ------------------
#       Project(s)
# ------------------

resource "google_project" "dc_project" {
  name = "${var.dc_project_name}"
  project_id = "${random_id.dc_id.hex}"
  billing_account = "${var.billing_account}"
  #folder_id = "${google_folder.folder.id}"
  folder_id = "${var.folder_name}"
  auto_create_network = "${var.auto_create_network}"

}


resource "google_project" "cloud_project" {
  name = "${var.cloud_project_name}"
  project_id = "${random_id.cloud_id.hex}"
  billing_account = "${var.billing_account}"
  #folder_id = "${google_folder.folder.id}"
  folder_id = "${var.folder_name}"
  auto_create_network = "${var.auto_create_network}"

}

# ----------------------------
#   Services
# ----------------------------

resource "google_project_services" "slurm_dc_services" {
 project = "${random_id.dc_id.hex}"
 services = [
   "deploymentmanager.googleapis.com",
   "compute.googleapis.com",
   "iam.googleapis.com",
   "storage-api.googleapis.com",
   "iamcredentials.googleapis.com",
   "oslogin.googleapis.com"

 ]
 depends_on = ["google_project.dc_project"]
}

# ----------------------------
#   Output
# ----------------------------

output "dc_project_id" {
  value = "${google_project.dc_project.project_id}"
}

output "dc_project_name" {
  value = "${google_project.dc_project.name}"
}

output "dc_project_number" {
  value = "${google_project.dc_project.number}"
}

output "cloud_project_id" {
  value = "${google_project.cloud_project.project_id}"
}
output "cloud_project_name" {
  value = "${google_project.cloud_project.name}"
}
output "cloud_project_number" {
  value = "${google_project.cloud_project.number}"
}
