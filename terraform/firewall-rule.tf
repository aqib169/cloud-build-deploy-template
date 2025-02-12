resource "google_compute_firewall" "allow-internal-traffic" {
  name = "allow-internal-traffic"
  network = google_compute_network.custom-vpc.name
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports = ["80", "443", "22", "5432"]
  }
  source_ranges = [var.subnet_cidr_range]
  depends_on = [ google_compute_network.custom-vpc ]
}