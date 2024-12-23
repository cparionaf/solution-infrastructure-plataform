module "gh_role_core" {
  source  = "terraform-module/github-oidc-provider/aws"
  version = "2.2.1"
  role_name = "gh-core-role-${var.environment}"
  create_oidc_provider = true
  create_oidc_role     = true
  role_description = "Deployment role frontend GitHub Actions S3/CloudFront"
  repositories = ["${var.organization_name}/*"]

    oidc_role_attach_policies = [
      "arn:aws:iam::aws:policy/AdministratorAccess"
  ]

}

