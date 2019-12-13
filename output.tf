output "kubernetes_ca_cert" {
  value       = tls_locally_signed_cert.kubernetes_ca.cert_pem
  description = "Kubernetes CA certificate."
}

output "kubernetes_ca_key" {
  value       = tls_private_key.kubernetes_ca.private_key_pem
  description = "Kubernetes CA certificate private key."
}

output "kubernetes_api_server_cert" {
  value       = tls_locally_signed_cert.api_server.cert_pem
  description = "Kubernetes API server certificates."
}

output "kubernetes_api_server_key" {
  value       = tls_private_key.api_server.private_key_pem
  description = "Kubernetes API server certificate private keys."
  sensitive   = true
}

output "kubernetes_api_server_kubelet_client_cert" {
  value       = tls_locally_signed_cert.api_server_kubelet_client.cert_pem
  description = "Kubernetes API server kubelet client certificate."
}

output "kubernetes_api_server_kubelet_client_key" {
  value       = tls_private_key.api_server_kubelet_client.private_key_pem
  description = "Kubernetes API server kubelet client private key."
}

output "service_account_public_key" {
  value       = tls_private_key.service_account.public_key_pem
  description = "Service account public key used by apiserver for verifying service accounts tokens."
}

output "service_account_private_key" {
  value       = tls_private_key.service_account.private_key_pem
  description = "Service account private key used by controller-manager for signing service accounts tokens."
}

output "kubernetes_front_proxy_ca_cert" {
  value       = tls_locally_signed_cert.kubernetes_front_proxy_ca.cert_pem
  description = "Kubernetes front proxy CA certificate."
}

output "kubernetes_api_server_front_proxy_client_cert" {
  value       = tls_locally_signed_cert.api_server_front_proxy_client.cert_pem
  description = "Kubernetes API server front proxy client certificate."
}

output "kubernetes_api_server_front_proxy_client_key" {
  value       = tls_private_key.api_server_front_proxy_client.private_key_pem
  description = "Kubernetes API server front proxy client private key."
}

output "kubernetes_admin_cert" {
  value       = tls_locally_signed_cert.admin.cert_pem
  description = "Kubernetes default admin certificate."
}

output "kubernetes_admin_key" {
  value       = tls_private_key.admin.private_key_pem
  description = "Kubernetes default admin private key."
}

output "kube_controller_manager_cert" {
  value       = tls_locally_signed_cert.kube_controller_manager.cert_pem
  description = "kube-controller-manager client certificate."
}

output "kube_controller_manager_key" {
  value       = tls_private_key.kube_controller_manager.private_key_pem
  description = "kube-controller-manager private key."
}

output "kube_scheduler_cert" {
  value       = tls_locally_signed_cert.kube_scheduler.cert_pem
  description = "kube-controller-manager client certificate."
}

output "kube_scheduler_key" {
  value       = tls_private_key.kube_scheduler.private_key_pem
  description = "kube-controller-manager private key."
}
