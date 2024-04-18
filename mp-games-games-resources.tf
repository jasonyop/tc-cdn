module "filtered_domains_million_plan_games_games_resources" {
  source = "./filter_domains/"

  count = var.million_plan.games.games_resources != null && try(var.million_plan.games.games_resources.enable, false) ? 1 : 0

  domains = local.web_server_domains
  filter = {
    domain_country  = var.module_info.domain_country
    be_app_category = "mp-games"
    devops_category = "games-resources"
  }
}

module "cdn_domains_million_plan_games_games_resources" {
  source = "./cdn_domain/"

  for_each = var.million_plan.games.games_resources != null && try(var.million_plan.games.games_resources.enable, false) ? module.filtered_domains_million_plan_games_games_resources[0].filtered_domains : {}

  fqdn = each.key
  area = each.value.area

  origin = {
    type     = var.cdn_domains.origin.source_type
    contents = var.cdn_domains.origin.source_content
  }

  ssl_cert = {
    id   = tencentcloud_ssl_certificate.ssl_certs[each.value.domain].id
    name = tencentcloud_ssl_certificate.ssl_certs[each.value.domain].name
  }

  tags = merge(each.value.tags, local.cdn_tags)
}

module "cdn_alarm_million_plan_games_games_resources" {
  source = "./cdn_alarm/"

  count = var.million_plan.games.games_resources != null && try(var.million_plan.games.games_resources.enable, false) ? 1 : 0

  resource_name   = local.resource_name
  domain_category = "mp-games-games-resources"
  cdn_domains = [
    # Only create alarm while the domain tag "active": true.
    for domain, config in module.filtered_domains_million_plan_games_games_resources[0].filtered_domains :
    domain if config.tags["active"]
  ]

  alert_rule_config = var.million_plan.games.games_resources.alarm

  notice_ids = var.notice_ids
}
