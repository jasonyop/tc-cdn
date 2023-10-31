data "vault_generic_secret" "ssl_certs" {
  for_each = toset(local.distincted_filtered_domains)

  path = "${local.mod_tmpl.ssl_cert_vault_path}/WILDCARD.${each.value}"
}

resource "vault_generic_secret" "tencentcloud_web_server_cdn" {
  path = local.mod_tmpl.terraform_vault_path

  data_json = jsonencode({
    CLOUD_MONITOR_ACCESS_KEY = try(tencentcloud_cam_user.cloud_monitor[0].secret_id, "")
    CLOUD_MONITOR_SECRET_KEY = try(tencentcloud_cam_user.cloud_monitor[0].secret_key, "")
    GAME_DEPLOY_ACCESS_KEY   = try(tencentcloud_cam_user.game_deploy_user[0].secret_id, "")
    GAME_DEPLOY_SECRET_KEY   = try(tencentcloud_cam_user.game_deploy_user[0].secret_key, "")
  })
}
