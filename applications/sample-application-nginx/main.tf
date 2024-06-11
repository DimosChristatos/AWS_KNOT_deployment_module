################################################################################
# Sample Application Namespace
################################################################################

resource "kubernetes_namespace" "sample-application-namespace" {
  metadata {
    annotations = {
      name = "sample-application"
    }

    labels = {
      application = "sample-nginx-application"
    }

    name = "sample-application"
  }
}

################################################################################
# Sample Application Policy to attach to the Role
################################################################################
# module "sample_application_iam_policy" {
#   source = "terraform-aws-modules/iam/aws//modules/iam-policy"

#   name        = "${var.env_name}_sample_application_policy"
#   path        = "/"
#   description = "sample Application Policy"

#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": [
#         "ec2:Describe*"
#       ],
#       "Effect": "Allow",
#       "Resource": "*"
#     }
#   ]
# }
# EOF
# }

# ################################################################################
# # Sample Application Role
# ################################################################################
# module "sample_application_role" {
#   source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

#   role_name = "${var.env_name}_sample_application"
#   role_policy_arns = {
#     policy = module.sample_application_iam_policy.arn
#   }

#   oidc_providers = {
#     main = {
#       provider_arn               = var.oidc_provider_arn
#       namespace_service_accounts = ["sample-application:sample-application-sa"]
#     }
#   }
# }

# ################################################################################
# # Sample Application Service Account
# ################################################################################

# resource "kubernetes_service_account" "service-account" {
#   metadata {
#     name      = "sample-application-sa"
#     namespace = kubernetes_namespace.sample-application-namespace.metadata[0].name
#     labels = {
#       "app.kubernetes.io/name" = "sample-application-sa"
#     }
#     annotations = {
#       "eks.amazonaws.com/role-arn"               = module.sample_application_role.iam_role_arn
#       "eks.amazonaws.com/sts-regional-endpoints" = "true"
#     }
#   }
# }

# ################################################################################
# # Sample Application Deployment
# ################################################################################

# resource "kubernetes_deployment_v1" "sample_application_deployment" {
#   metadata {
#     name      = "sample-application-deployment"
#     namespace = kubernetes_namespace.sample-application-namespace.metadata[0].name
#     labels = {
#       app = "nginx"
#     }
#   }

#   spec {
#     replicas = 2

#     selector {
#       match_labels = {
#         app = "nginx"
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           app = "nginx"
#         }
#       }

#       spec {
#         //service_account_name = kubernetes_service_account.service-account.metadata[0].name
#         container {
#           image = "nginx:latest"
#           name  = "nginx"
#         }
#       }
#     }
#   }
# }

# resource "kubernetes_deployment_v1" "sample_application_deployment_v2" {
#   metadata {
#     name      = "sample-application-deployment-v2"
#     namespace = kubernetes_namespace.sample-application-namespace.metadata[0].name
#     labels = {
#       app = "nginx_v2"
#     }
#   }

#   spec {
#     replicas = 2

#     selector {
#       match_labels = {
#         app = "nginx_v2"
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           app = "nginx_v2"
#         }
#       }

#       spec {
#         //service_account_name = kubernetes_service_account.service-account.metadata[0].name
#         container {
#           image = "nginx:1.21.6"
#           name  = "nginx"
#         }
#       }
#     }
#   }
# }


################################################################################
# Sample Application Service
################################################################################

# resource "kubernetes_service_v1" "sample_application_svc" {
#   metadata {
#     name      = "sample-application-svc"
#     namespace = kubernetes_namespace.sample-application-namespace.metadata[0].name
#   }
#   spec {
#     selector = {
#       app = "nginx"
#     }
#     session_affinity = "ClientIP"
#     port {
#       port        = 80
#       target_port = 80
#     }

#     type = "NodePort"
#   }
# }

# resource "kubernetes_service_v1" "sample_application_svc_v2" {
#   metadata {
#     name      = "sample-application-svc-v2"
#     namespace = kubernetes_namespace.sample-application-namespace.metadata[0].name
#   }
#   spec {
#     selector = {
#       app = "nginx_v2"
#     }
#     session_affinity = "ClientIP"
#     port {
#       port        = 80
#       target_port = 80
#     }

#     type = "NodePort"
#   }
# }

################################################################################
# Sample Application Ingress
################################################################################

# resource "kubernetes_ingress_v1" "sample_application_ingress" {
#   metadata {
#     name      = "sample-application-ingress"
#     namespace = kubernetes_namespace.sample-application-namespace.metadata[0].name
#     annotations = {
#       "alb.ingress.kubernetes.io/scheme" = "internet-facing"
#     }
#   }

#   wait_for_load_balancer = "true"

#   spec {
#     ingress_class_name = "alb"
#     tls {
#       secret_name = "tls-secret"
#     }
#     default_backend {
#       service {
#         name = "sample-application-svc"
#         port {
#           number = 80
#         }
#       }
#     }
    
#   }
# }

