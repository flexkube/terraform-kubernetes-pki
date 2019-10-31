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
  description = "Kubernetes API server kubelet client key."
}

output "service_account_public_key" {
  value       = tls_private_key.service_account.public_key_pem
  description = "Service account public key used by apiserver for verifying service accounts tokens."
}

output "service_account_private_key" {
  value       = tls_private_key.service_account.private_key_pem
  description = "Service account private key used by controller-manager for signing service accounts tokens."
}
