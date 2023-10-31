module "filtered_domains_games_games_entry" {
  source = "./filter_domains/"

  count = var.games.games_entry != null && try(var.games.games_entry.enable, false) ? 1 : 0

  domains = local.web_server_domains
  filter = {
    domain_country  = var.module_info.domain_country
    be_app_category = "games"
    devops_category = "games-entry"
  }
}

module "cdn_domains_games_games_entry" {
  source = "./cdn_domain/"

  for_each = var.games.games_entry != null && try(var.games.games_entry.enable, false) ? module.filtered_domains_games_games_entry[0].filtered_domains : {}

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

module "cdn_alarm_games_games_entry" {
  source = "./cdn_alarm/"

  count = var.games.games_entry != null && try(var.games.games_entry.enable, false) ? 1 : 0

  resource_name   = local.resource_name
  domain_category = "games-games-entry"
  cdn_domains     = keys(module.filtered_domains_games_games_entry[0].filtered_domains)

  alert_rule_config = var.games.games_entry.alarm

  notice_ids = var.notice_ids
}
