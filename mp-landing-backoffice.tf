module "filtered_domains_million_plan_landing_backoffice" {
  source = "./filter_domains/"

  count = var.million_plan.landing.backoffice != null && try(var.million_plan.landing.backoffice.enable, false) ? 1 : 0

  domains = local.web_server_domains
  filter = {
    domain_country  = var.module_info.domain_country
    be_app_category = "mp-landing"
    devops_category = "backoffice"
  }
}

module "cdn_domains_million_plan_landing_backoffice" {
  source = "./cdn_domain/"

  for_each = var.million_plan.landing.backoffice != null && try(var.million_plan.landing.backoffice.enable, false) ? module.filtered_domains_million_plan_landing_backoffice[0].filtered_domains : {}

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

module "cdn_alarm_million_plan_landing_backoffice" {
  source = "./cdn_alarm/"

  count = var.million_plan.landing.backoffice != null && try(var.million_plan.landing.backoffice.enable, false) ? 1 : 0

  resource_name   = local.resource_name
  domain_category = "mp-landing-backoffice"
  cdn_domains     = keys(module.filtered_domains_million_plan_landing_backoffice[0].filtered_domains)

  alert_rule_config = var.million_plan.landing.backoffice.alarm

  notice_ids = var.notice_ids
}
