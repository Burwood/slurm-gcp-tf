
# -------------------------------------------

variable "dc_bucket_name" {
  default = "bucket"
}

variable "dc_name_location" {
    default = "US"
}

variable "storage_class" {
  default     = "REGIONAL"
}

variable "force_destroy" {
  type = bool
  default = false
}

variable "num_newer_versions" {
  default = 10
}

variable "versioning_enabled" {
  default = true
}

variable "role_entity" {
    type = "list"
    default = []
    description = "List of role/entity pairs in the form ROLE:entity.Must be set if predefined_acl is not"
}

# -------------------------------------------
#  Resources
# -------------------------------------------
resource "random_id" "dc_bucket" {
  byte_length = "${var.random_id}"
  prefix = "${var.dc_project_name}-${var.dc_bucket_name}-"
}

resource "google_storage_bucket" "dc_bucket" {
  name = "${random_id.dc_bucket.hex}"
  location = "${var.dc_name_location}"
  project = "${google_project.dc_project.id}"
#  storage_class = "${var.storage_class}"
}


# -------------------------------------------
#  Outputs
# -------------------------------------------

output "bucket_url" {
  value = "${google_storage_bucket.dc_bucket.url}"
}

output "bucket_self_link" {
  value = "${google_storage_bucket.dc_bucket.self_link}"
}
