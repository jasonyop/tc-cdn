##################################################
# SSL CERTIFICATE
##################################################

resource "tencentcloud_ssl_certificate" "ssl_certs" {
  for_each = toset(local.distincted_filtered_domains)

  name = "${local.ssl_cert_resource_name}-WILDCARD.${each.key}"
  type = "SVR"
  cert = chomp(data.vault_generic_secret.ssl_certs[each.key].data["fullchain.pem"])
  key  = chomp(data.vault_generic_secret.ssl_certs[each.key].data["privkey.pem"])
}

##################################################
# CAM User for CDN cloud monitor
##################################################

resource "tencentcloud_cam_user" "cloud_monitor" {
  count = var.cdn_vendor.allow_create_cam_user ? 1 : 0

  name                = "${local.resource_name}-cloud-monitor"
  remark              = "${local.resource_name} Cloud Monitor service account."
  console_login       = false
  use_api             = true
  need_reset_password = false
  force_delete        = true
}

resource "tencentcloud_cam_policy" "cloud_monitor_policy" {
  count = var.cdn_vendor.allow_create_cam_user ? 1 : 0

  name        = "${local.resource_name}-cloud-monitor"
  document    = <<EOF
{
  "version": "2.0",
  "statement": [
    {
      "action": [
        "monitor:Describe*",
        "monitor:Get*"
      ],
      "effect": "allow",
      "resource": [
        "*"
      ]
    }
  ]
}
EOF
  description = "${local.resource_name} Cloud Monitor policy."
}

resource "tencentcloud_cam_user_policy_attachment" "cloud_monitor_policy_attach" {
  count = var.cdn_vendor.allow_create_cam_user ? 1 : 0

  user_name = tencentcloud_cam_user.cloud_monitor[0].id
  policy_id = tencentcloud_cam_policy.cloud_monitor_policy[0].id
}

##################################################
# CAM User for Game deploy
##################################################

resource "tencentcloud_cam_user" "game_deploy_user" {
  count = var.cdn_vendor.allow_create_cam_user ? 1 : 0

  name                = "${local.resource_name}-game-deploy-clear-cache"
  remark              = "${local.resource_name} game deploy service account."
  console_login       = false
  use_api             = true
  need_reset_password = false
  force_delete        = true
}

resource "tencentcloud_cam_policy" "game_deploy_policy" {
  count = var.cdn_vendor.allow_create_cam_user ? 1 : 0

  name        = "${local.resource_name}-game-deploy-clear-cache"
  document    = <<EOF
{
  "version": "2.0",
  "statement": [
    {
      "action": [
        "cdn:Describe*",
        "cdn:Get*",
        "cdn:PurgeUrlsCache",
        "cdn:PushUrlsCache"
      ],
      "effect": "allow",
      "resource": [
        "*"
      ]
    }
  ]
}
EOF
  description = "${local.resource_name} game deploy policy."
}

resource "tencentcloud_cam_user_policy_attachment" "game_deploy_policy_attach" {
  count = var.cdn_vendor.allow_create_cam_user ? 1 : 0

  user_name = tencentcloud_cam_user.game_deploy_user[0].id
  policy_id = tencentcloud_cam_policy.game_deploy_policy[0].id
}
