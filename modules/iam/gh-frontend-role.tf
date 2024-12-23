module "gh_role" {
  source  = "terraform-module/github-oidc-provider/aws"
  version = "2.2.1"
  role_name = "gh-frontend-role-${var.environment}"
  create_oidc_provider = true
  create_oidc_role     = true
  role_description = "Deployment role frontend GitHub Actions S3/CloudFront"
  repositories = ["${var.organization_name}/*"]

    oidc_role_attach_policies = [
    aws_iam_policy.frontend_deployment.arn
  ]

}

resource "aws_iam_policy" "frontend_deployment" {
  name        = "frontend-deployment-policy"
  description = "Política para despliegue de frontend en S3 y invalidación de CloudFront"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:DeleteObject"
        ]
        Resource = [
          "arn:aws:s3:::*",
          "arn:aws:s3:::*/*"          
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "cloudfront:CreateInvalidation",
          "cloudfront:GetInvalidation",
          "cloudfront:ListInvalidations"
        ]
        Resource = [
           "arn:aws:cloudfront::*:distribution/*" 
        ]
      }
    ]
  })
}