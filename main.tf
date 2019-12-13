# Kubernetes CA private key and certificate
resource "tls_private_key" "kubernetes_ca" {
  algorithm = "RSA"
  rsa_bits  = var.rsa_bits
}

resource "tls_cert_request" "kubernetes_ca" {
  key_algorithm   = tls_private_key.kubernetes_ca.algorithm
  private_key_pem = tls_private_key.kubernetes_ca.private_key_pem

  subject {
    # This is CN recommended by K8s: https://kubernetes.io/docs/setup/best-practices/certificates/
    common_name  = "kubernetes-ca"
    organization = var.organization
  }
}

resource "tls_locally_signed_cert" "kubernetes_ca" {
  cert_request_pem = tls_cert_request.kubernetes_ca.cert_request_pem

  ca_key_algorithm   = var.root_ca_algorithm
  ca_private_key_pem = var.root_ca_key
  ca_cert_pem        = var.root_ca_cert

  is_ca_certificate = true

  # TODO make it configurable
  validity_period_hours = 8760

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "cert_signing",
  ]
}

# kube-apiserver private key and server certificate for HTTPS serving
resource "tls_private_key" "api_server" {
  algorithm = "RSA"
  rsa_bits  = var.rsa_bits
}

resource "tls_cert_request" "api_server" {
  key_algorithm   = tls_private_key.api_server.algorithm
  private_key_pem = tls_private_key.api_server.private_key_pem

  subject {
    common_name  = "kube-apiserver"
    organization = var.organization
  }

  ip_addresses = concat([
    "127.0.0.1",
    # First address of Service CIDR
    "11.0.0.1",
  ], var.api_server_ips, var.api_server_external_ips)

  dns_names = concat([
    "localhost",
    # Recommended by TLS certificates guide
    "kubernetes",
    "kubernetes.default",
    "kubernetes.default.svc",
    "kubernetes.default.svc.cluster",
    "kubernetes.default.svc.cluster.local",
  ], var.api_server_external_names)
}

resource "tls_locally_signed_cert" "api_server" {
  cert_request_pem = tls_cert_request.api_server.cert_request_pem

  ca_key_algorithm   = tls_cert_request.kubernetes_ca.key_algorithm
  ca_private_key_pem = tls_private_key.kubernetes_ca.private_key_pem
  ca_cert_pem        = tls_locally_signed_cert.kubernetes_ca.cert_pem

  # TODO Again, configurable
  validity_period_hours = 8760

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

# kube-apiserver private key and client certificate for kubelet communication
resource "tls_private_key" "api_server_kubelet_client" {
  algorithm = "RSA"
  rsa_bits  = var.rsa_bits
}

resource "tls_cert_request" "api_server_kubelet_client" {
  key_algorithm   = tls_private_key.api_server_kubelet_client.algorithm
  private_key_pem = tls_private_key.api_server_kubelet_client.private_key_pem

  subject {
    common_name  = "kube-apiserver-kubelet-client"
    organization = "system:masters"
  }
}

resource "tls_locally_signed_cert" "api_server_kubelet_client" {
  cert_request_pem = tls_cert_request.api_server_kubelet_client.cert_request_pem

  ca_key_algorithm   = tls_cert_request.kubernetes_ca.key_algorithm
  ca_private_key_pem = tls_private_key.kubernetes_ca.private_key_pem
  ca_cert_pem        = tls_locally_signed_cert.kubernetes_ca.cert_pem

  # TODO Again, configurable
  validity_period_hours = 8760

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "client_auth",
  ]
}

# TLS private key for signing service account tokens
resource "tls_private_key" "service_account" {
  algorithm = "RSA"
  rsa_bits  = var.rsa_bits
}

# Kubernetes front proxy CA private key and certificate for aggregation layer
resource "tls_private_key" "kubernetes_front_proxy_ca" {
  algorithm = "RSA"
  rsa_bits  = var.rsa_bits
}

resource "tls_cert_request" "kubernetes_front_proxy_ca" {
  key_algorithm   = tls_private_key.kubernetes_front_proxy_ca.algorithm
  private_key_pem = tls_private_key.kubernetes_front_proxy_ca.private_key_pem

  subject {
    # This is CN recommended by K8s: https://kubernetes.io/docs/setup/best-practices/certificates/
    common_name  = "kubernetes-front-proxy-ca"
    organization = var.organization
  }
}

resource "tls_locally_signed_cert" "kubernetes_front_proxy_ca" {
  cert_request_pem = tls_cert_request.kubernetes_front_proxy_ca.cert_request_pem

  ca_key_algorithm   = var.root_ca_algorithm
  ca_private_key_pem = var.root_ca_key
  ca_cert_pem        = var.root_ca_cert

  is_ca_certificate = true

  # TODO make it configurable
  validity_period_hours = 8760

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "cert_signing",
  ]
}

# kube-apiserver private key and certificate for front proxy
resource "tls_private_key" "api_server_front_proxy_client" {
  algorithm = "RSA"
  rsa_bits  = var.rsa_bits
}

resource "tls_cert_request" "api_server_front_proxy_client" {
  key_algorithm   = tls_private_key.api_server_front_proxy_client.algorithm
  private_key_pem = tls_private_key.api_server_front_proxy_client.private_key_pem

  subject {
    common_name  = "front-proxy-client"
    organization = var.organization
  }
}

resource "tls_locally_signed_cert" "api_server_front_proxy_client" {
  cert_request_pem = tls_cert_request.api_server_front_proxy_client.cert_request_pem

  ca_key_algorithm   = tls_cert_request.kubernetes_front_proxy_ca.key_algorithm
  ca_private_key_pem = tls_private_key.kubernetes_front_proxy_ca.private_key_pem
  ca_cert_pem        = tls_locally_signed_cert.kubernetes_front_proxy_ca.cert_pem

  # TODO Again, configurable
  validity_period_hours = 8760

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "client_auth",
  ]
}

# Admin private key and certificate
resource "tls_private_key" "admin" {
  algorithm = "RSA"
  rsa_bits  = var.rsa_bits
}

resource "tls_cert_request" "admin" {
  key_algorithm   = tls_private_key.admin.algorithm
  private_key_pem = tls_private_key.admin.private_key_pem

  subject {
    common_name  = "kubernetes-admin"
    organization = "system:masters"
  }
}

resource "tls_locally_signed_cert" "admin" {
  cert_request_pem = tls_cert_request.admin.cert_request_pem

  ca_key_algorithm   = tls_cert_request.kubernetes_ca.key_algorithm
  ca_private_key_pem = tls_private_key.kubernetes_ca.private_key_pem
  ca_cert_pem        = tls_locally_signed_cert.kubernetes_ca.cert_pem

  # TODO Again, configurable
  validity_period_hours = 8760

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "client_auth",
  ]
}

# kube-controller-manager private key and certificate
resource "tls_private_key" "kube_controller_manager" {
  algorithm = "RSA"
  rsa_bits  = var.rsa_bits
}

resource "tls_cert_request" "kube_controller_manager" {
  key_algorithm   = tls_private_key.kube_controller_manager.algorithm
  private_key_pem = tls_private_key.kube_controller_manager.private_key_pem

  subject {
    common_name  = "system:kube-controller-manager"
    organization = var.organization
  }
}

resource "tls_locally_signed_cert" "kube_controller_manager" {
  cert_request_pem = tls_cert_request.kube_controller_manager.cert_request_pem

  ca_key_algorithm   = tls_cert_request.kubernetes_ca.key_algorithm
  ca_private_key_pem = tls_private_key.kubernetes_ca.private_key_pem
  ca_cert_pem        = tls_locally_signed_cert.kubernetes_ca.cert_pem

  # TODO Again, configurable
  validity_period_hours = 8760

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "client_auth",
  ]
}

# kube-scheduler private key and certificate
resource "tls_private_key" "kube_scheduler" {
  algorithm = "RSA"
  rsa_bits  = var.rsa_bits
}

resource "tls_cert_request" "kube_scheduler" {
  key_algorithm   = tls_private_key.kube_scheduler.algorithm
  private_key_pem = tls_private_key.kube_scheduler.private_key_pem

  subject {
    common_name  = "system:kube-scheduler"
    organization = var.organization
  }
}

resource "tls_locally_signed_cert" "kube_scheduler" {
  cert_request_pem = tls_cert_request.kube_scheduler.cert_request_pem

  ca_key_algorithm   = tls_cert_request.kubernetes_ca.key_algorithm
  ca_private_key_pem = tls_private_key.kubernetes_ca.private_key_pem
  ca_cert_pem        = tls_locally_signed_cert.kubernetes_ca.cert_pem

  # TODO Again, configurable
  validity_period_hours = 8760

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "client_auth",
  ]
}
