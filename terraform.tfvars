# Application Definition 
company     = "webfusion"
app_name    = "kube-cluster"
app_domain  = "garystimber.site"
environment = "test" # Dev, Test, Prod, etc

# GCP Settings
gcp_project   = "mypersonaluse-396811"
gcp_region    = "europe-north1"
gcp_zone      = "europe-north1-a"
gcp_auth_file = "../gcp_cred/root.json"

# GCP Netwok
network-subnet-cidr = "10.10.10.0/24"

# Linux VM
linux_instance_type = "e2-medium"
