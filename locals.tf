data "http" "client_ip" {
  count = var.allow_own_ip ? 1 : 0
  url   = "https://ipv4.icanhazip.com"
}
