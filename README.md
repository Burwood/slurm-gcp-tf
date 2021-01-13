# Slurm on Google Cloud Platform

## Instructions to run on modified version

* Navigate to tf/examples/basic
* Create compute instance based on Centos7 Image.  Install Intel MPI and other libraries.
* Create compute instance.  On Image define image family.  Write down the image family name.
* Open utath.tfvars
* Edit
	* line 2 for project with your project ID
	*line 83.  Edit settings for instance type, disk type. For compute image set to {project-id}/{image-family}.  Image family comes from a previous step
	*Create as many partitions blocks as needed for types of compute nodes
	*Save file
* Run terraform init
* Run terraform plan -var-file=utah.tfvars
* Run terraform apply -var-file=utah.tfvars




## Troubleshooting
1. Nodes aren't bursting?
   1. Check /var/log/slurm/resume.log for any errors
   2. Try creating nodes manually by calling resume.py manually **as the
      "slurm" user**.
      * **NOTE:** If you run resume.py manually with root, subsequent calls to
	resume.py by the "slurm" user may fail because resume.py's log file
	will be owned by root.
   3. Check the slurmctld logs
      * /var/log/slurm/slurmctld.log
      * Turn on the *PowerSave* debug flag to get more information.
        e.g.
        ```
        $ scontrol setdebugflags +powersave
        ...
        $ scontrol setdebugflags -powersave
        ```
2. Cluster environment not fully coming up  
   For example:
   * Slurm not being installed
   * Compute images never being stopped
   * etc.

   1. Check syslog (/var/log/messages) on instances for any errors. **HINT:**
      search for last mention of "startup-script."
3. General debugging
   * check logs
     * /var/log/messages
     * /var/log/slurm/*.log
     * **NOTE:** syslog and all Slurm logs can be viewed in [GCP Console's Logs Viewer](https://console.cloud.google.com/logs/viewer).
   * check GCP quotas
