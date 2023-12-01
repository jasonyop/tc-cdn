module "filtered_domains_million_plan_games_app" {
  source = "./filter_domains/"

  count = var.million_plan.games.app != null && try(var.million_plan.games.app.enable, false) ? 1 : 0

  domains = local.web_server_domains
  filter = {
    domain_country  = var.module_info.domain_country
    be_app_category = "mp-games"
    devops_category = "app"
  }
}

module "cdn_domains_million_plan_games_app" {
  source = "./cdn_domain/"

  for_each = var.million_plan.games.app != null && try(var.million_plan.games.app.enable, false) ? module.filtered_domains_million_plan_games_app[0].filtered_domains : {}

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

module "cdn_alarm_million_plan_games_app" {
  source = "./cdn_alarm/"

  count = var.million_plan.games.app != null && try(var.million_plan.games.app.enable, false) ? 1 : 0

  resource_name   = local.resource_name
  domain_category = "mp-games-app"
  cdn_domains     = keys(module.filtered_domains_million_plan_games_app[0].filtered_domains)

  alert_rule_config = var.million_plan.games.app.alarm

  notice_ids = var.notice_ids
}
