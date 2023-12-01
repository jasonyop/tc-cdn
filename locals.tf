locals {
  mod_tmpl               = data.st-utilities_module_tmpl.template.module_tmpl
  resource_name          = local.mod_tmpl.resource_name
  ssl_cert_resource_name = local.mod_tmpl.ssl_cert_resource_name

  cdn_tags = {
    brand = var.module_info.brand
    env   = var.module_info.env
    # be_app_category will be passed in with 20twenty config.
  }

  web_server_domains = jsondecode(base64decode(data.external.web_server_domains.result["result"])).domains

  merged_filtered_domains = merge(
    try(module.filtered_domains_crm_backoffice[0].filtered_domains, {}),
    try(module.filtered_domains_million_plan_games_app[0].filtered_domains, {}),
    try(module.filtered_domains_million_plan_games_games_entry[0].filtered_domains, {}),
    try(module.filtered_domains_million_plan_games_games_resources[0].filtered_domains, {}),
    try(module.filtered_domains_million_plan_games_public[0].filtered_domains, {}),
    try(module.filtered_domains_million_plan_landing_backoffice[0].filtered_domains, {}),
  )
  distincted_filtered_domains = distinct([
    for domain in local.merged_filtered_domains : domain.domain
  ])

  merged_tencentcloud_cdn_output = merge(
    try(module.cdn_domains_crm_backoffice, {}),
    try(module.cdn_domains_million_plan_games_app, {}),
    try(module.cdn_domains_million_plan_games_games_entry, {}),
    try(module.cdn_domains_million_plan_games_games_resources, {}),
    try(module.cdn_domains_million_plan_games_public, {}),
    try(module.cdn_domains_million_plan_landing_backoffice, {}),
  )
}
