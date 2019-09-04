# ------------------------------
#       Variables
# ------------------------------


# ------------------------------
#       Resources
# ------------------------------
# -------------------
#  Slurm DC
# -------------------

resource "google_project_iam_binding" "dc_editor" {
  project = "${google_project.dc_project.project_id}"
  role = "roles/editor"
  members = ["user:astrong@burwood.com","user:dspeck@burwood.com","serviceAccount:${google_project.dc_project.number}@cloudservices.gserviceaccount.com"]
}

resource "google_project_iam_binding" "dc_oslogin" {
  project = "${google_project.dc_project.project_id}"
  role = "roles/compute.osAdminLogin"
  members = ["user:astrong@burwood.com","user:dspeck@burwood.com"]
}
/*
resource "google_organization_iam_binding" "dc_osloginExternal" {
#  project = "${google_project.dc_project.project_id}"
  org_id = "${var.org_id}"
  role = "roles/compute.osLoginExternalUser"
  members = ["user:astrong@burwood.com","user:dspeck@burwood.com"]
}
*/

# -------------------
#   Slurm Cloud
# -------------------
resource "google_project_iam_binding" "cloud_editor" {
  project = "${google_project.cloud_project.project_id}"
  role = "roles/editor"
  members = ["user:astrong@burwood.com","user:dspeck@burwood.com"]
}

resource "google_project_iam_binding" "cloud_iampol" {
  project = "${google_project.cloud_project.project_id}"
  role = "roles/resourcemanager.projectIamAdmin"
  members = ["user:astrong@burwood.com","user:dspeck@burwood.com"]
}

/*
resource "google_project_iam_member" "dc_editor2" {
  project = "${google_project.dc_project.project_id}"
  role = "roles/editor"
  member = "user:dspeck@burwood.com"
}

resource "google_project_iam_member" "cloud_editor" {
  project = "${google_project.cloud_project.project_id}"
  role = "roles/editor"
  member = "user:astrong@burwood.com"
}

resource "google_project_iam_member" "cloud_editor2" {
  project = "${google_project.cloud_project.project_id}"
  role = "roles/editor"
  member = "user:dspeck@burwood.com"
}
*/
