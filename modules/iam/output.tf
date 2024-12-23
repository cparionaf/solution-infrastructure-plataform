output "role_arn" {
  value = module.gh_role_frontend.oidc_provider_arn
}

output "role_arn_core" {
  value = module.gh_role_core.oidc_provider_arn
}