#########################
## GCP Linux VM - Main ##
#########################

# Terraform plugin for creating random ids
resource "random_id" "instance_id" {
  byte_length = 4
}

# Bootstrapping Script to Install Apache
data "template_file" "linux-metadata" {
  template = <<EOF
sudo swapoff -a;
sudo apt install docker.io -y;
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add;
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list;
sudo apt update;
sudo apt install kubeadm kubelet kubectl kubernetes-cni -y;
EOF
}

resource "google_compute_address" "static" {
  name = "ipv4-address"
}

# Create VM
resource "google_compute_instance" "vm_instance_public" {
  name         = "master-${lower(var.company)}-${lower(var.app_name)}-${var.environment}-vm"
  machine_type = var.linux_instance_type
  zone         = var.gcp_zone
  hostname     = "${var.app_name}-vm${random_id.instance_id.hex}.${var.app_domain}"
  tags         = ["ssh", "http"]

  boot_disk {
    initialize_params {
      image = var.ubuntu_2004_sku
    }
  }

  metadata_startup_script = data.template_file.linux-metadata.rendered

  network_interface {
    network    = google_compute_network.vpc.name
    subnetwork = google_compute_subnetwork.network_subnet.name
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }
}


resource "google_compute_address" "static2" {
  name = "ipv4-address2"
}

# Create VM
resource "google_compute_instance" "vm_instance_public2" {
  name         = "woker-1-${lower(var.company)}-${lower(var.app_name)}-${var.environment}-vm"
  machine_type = var.linux_instance_type
  zone         = var.gcp_zone
  hostname     = "${var.app_name}-vm${random_id.instance_id.hex}.${var.app_domain}"
  tags         = ["ssh", "http"]

  boot_disk {
    initialize_params {
      image = var.ubuntu_2004_sku
    }
  }

  metadata_startup_script = data.template_file.linux-metadata.rendered

  network_interface {
    network    = google_compute_network.vpc.name
    subnetwork = google_compute_subnetwork.network_subnet.name
    access_config {
      nat_ip = google_compute_address.static2.address
    }
  }
}

resource "google_compute_address" "static3" {
  name = "ipv4-address3"
}

# Create VM
resource "google_compute_instance" "vm_instance_public3" {
  name         = "worker-2-${lower(var.company)}-${lower(var.app_name)}-${var.environment}-vm"
  machine_type = var.linux_instance_type
  zone         = var.gcp_zone
  hostname     = "${var.app_name}-vm${random_id.instance_id.hex}.${var.app_domain}"
  tags         = ["ssh", "http"]

  boot_disk {
    initialize_params {
      image = var.ubuntu_2004_sku
    }
  }

  metadata_startup_script = data.template_file.linux-metadata.rendered

  network_interface {
    network    = google_compute_network.vpc.name
    subnetwork = google_compute_subnetwork.network_subnet.name
    access_config {
      nat_ip = google_compute_address.static3.address
    }
  }
}
