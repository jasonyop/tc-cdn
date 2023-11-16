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

##################################################
# AppRole local
##################################################

locals {
  // approle_name shared among openstack, multi-clouds web-servers and CDN.
  game_deploy_approle_name = "${var.module_info.brand}-${var.module_info.env}-game-deploy-app-role"
  # use sort to prevent changes because merging list might be random.
  game_deploy_overall_policies = sort(setunion(try(jsondecode(data.vault_generic_secret.game_deploy_approle.0.data["token_policies"]), []), [vault_policy.game_deploy.name]))
}

##################################################
# Create AppRole for game-deploy
##################################################

// Query appRole, if exist then grab policies from generic_secret.
data "vault_approle_auth_backend_role_id" "game_deploy_approle" {
  backend   = "approle"
  role_name = local.game_deploy_approle_name
}

data "vault_generic_secret" "game_deploy_approle" {
  count = data.vault_approle_auth_backend_role_id.game_deploy_approle.role_name != null ? 1 : 0

  path = "auth/approle/role/${local.game_deploy_approle_name}"
}

// Create new app role when data.vault_approle_auth_backend_role_id is not found,
// else attach policies.
resource "vault_approle_auth_backend_role" "game_deploy" {
  backend               = "approle"
  role_name             = local.game_deploy_approle_name
  bind_secret_id        = false
  secret_id_bound_cidrs = var.vault_approle_cidrs_for_game_deploy
  token_ttl             = 30
  token_policies        = local.game_deploy_overall_policies
}

resource "vault_policy" "game_deploy" {
  name = "${local.mod_tmpl.module_name}-game-deploy"

  policy = <<EOT
# For accessing Clouds Credentials.
path "devops/data/terraform/+/+/+/tencentcloud-web-server-cdn-${var.module_info.domain_country}" {
  capabilities = ["list", "read"]
}
EOT
}
