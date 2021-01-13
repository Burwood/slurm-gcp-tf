cluster_name = "g1"
project      = "slurm-mp-cloud"
zone         = "us-central1-b"

# network_name            = "<existing network name>"
# subnetwork_name         = "<existing subnetwork name>"
# shared_vpc_host_project = "<vpc host project>"

# disable_controller_public_ips = true
# disable_login_public_ips      = true
# disable_compute_public_ips    = true

# ompi_version  = null # e.g. v3.1.x
# slurm_version = "19.05-latest"
# suspend_time  = 300

# controller_machine_type = "n1-standard-2"
# controller_disk_type    = "pd-standard"
# controller_disk_size_gb = 50
# controller_labels = {
#   key1 = "val1"
#   key2 = "val2"
# }
# controller_service_account = "default"
# controller_scopes          = ["https://www.googleapis.com/auth/cloud-platform"]
# cloudsql = {
#   server_ip = "<cloudsql ip>"
#   user      = "slurm"
#   password  = "verysecure"
#   db_name   = "slurm_accounting"
# }
# controller_secondary_disk      = false
# controller_secondary_disk_size = 100
# controller_secondary_disk_type = "pd-ssd"

# login_machine_type = "n1-standard-2"
# login_disk_type    = "pd-standard"
# login_disk_size_gb = 20
# login_labels = {
#   key1 = "val1"
#   key2 = "val2"
# }
# login_node_count = 1
# login_node_service_account = "default"
# login_node_scopes          = [
#   "https://www.googleapis.com/auth/monitoring.write",
#   "https://www.googleapis.com/auth/logging.write"
# ]

# Optional network storage fields
# network_storage is mounted on all instances
# login_network_storage is mounted on controller and login instances
# network_storage = [{
#   server_ip     = "<storage host>"
#   remote_mount  = "/home"
#   local_mount   = "/home"
#   fs_type       = "nfs"
#   mount_options = null
# }]
#
# login_network_storage = [{
#   server_ip     = "<storage host>"
#   remote_mount  = "/net_storage"
#   local_mount   = "/shared"
#   fs_type       = "nfs"
#   mount_options = null
# }]

# compute_image_machine_type = "n1-standard-2"
# compute_image_disk_type    = "pd-standard"
# compute_image_disk_size_gb = 20
# compute_image_labels = {
#   key1 = "val1"
#   key2 = "val2"
# }

# compute_node_service_account = "default"
# compute_node_scopes          = [
#   "https://www.googleapis.com/auth/monitoring.write",
#   "https://www.googleapis.com/auth/logging.write"
# ]

partitions = [
  { name                 = "partition1"
    machine_type         = "n1-standard-2"
    static_node_count    = 0
    max_node_count       = 10
    zone                 = "us-central1-a"
    compute_image        = "slurm-mp-cloud/partition1"
    #compute_image        = "projects/centos-cloud/global/images/centos-7-v20201216"
    compute_disk_type    = "pd-standard"
    compute_disk_size_gb = 20
    compute_labels       = {}
    cpu_platform         = null
    gpu_count            = 0
    gpu_type             = null
    network_storage      = []
    preemptible_bursting = false
    vpc_subnet           = null
  },
  { name                 = "partition2"
    machine_type         = "n1-standard-4"
    static_node_count    = 0
    max_node_count       = 20
    zone                 = "us-central1-b"
    compute_image        = "slurm-mp-cloud/partition2"
    compute_disk_type    = "pd-ssd"
    compute_disk_size_gb = 20
    compute_labels       = {
      key1 = "val1"
      key2 = "val2"
    }
    cpu_platform         = "Intel Skylake"
    gpu_count            = 0
    gpu_type             = null
    network_storage      = []
    preemptible_bursting = false
    vpc_subnet           = null
    }
]