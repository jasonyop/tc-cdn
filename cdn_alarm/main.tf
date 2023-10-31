resource "tencentcloud_monitor_alarm_policy" "cdn_monitor_policy" {
  count = var.alert_rule_config.query_per_minute.enable || var.alert_rule_config.gigabytes_downloaded.enable ? 1 : 0

  policy_name  = "${var.resource_name}-${var.domain_category}"
  remark       = "${var.resource_name}-${var.domain_category}"
  monitor_type = "MT_QCE"
  project_id   = "0" # 1: no project, 0: default project

  # For all namespaces, refer https://intl.cloud.tencent.com/document/product/248/39565
  namespace = "cdn_domain"

  conditions {
    is_union_rule = 0

    # For all CDN metrics, refer: https://intl.cloud.tencent.com/document/product/248/39554

    # Number of requests
    dynamic "rules" {
      for_each = var.alert_rule_config.query_per_minute.enable ? toset([
        var.alert_rule_config.query_per_minute.threshold
      ]) : []

      content {
        metric_name      = "Requests"
        period           = 60
        operator         = "ge"
        value            = rules.value
        continue_period  = 3
        notice_frequency = 900
        is_power_notice  = 0
      }
    }

    # Traffic in GB
    dynamic "rules" {
      for_each = var.alert_rule_config.gigabytes_downloaded.enable ? toset([
        var.alert_rule_config.gigabytes_downloaded.threshold
      ]) : []

      content {
        metric_name      = "Flux"
        period           = 60
        operator         = "ge"
        value            = rules.value
        continue_period  = 3
        notice_frequency = 900
        is_power_notice  = 0
      }
    }
  }

  notice_ids = var.notice_ids
}

resource "tencentcloud_monitor_policy_binding_object" "cdn_monitor_binding" {
  count = var.alert_rule_config.query_per_minute.enable || var.alert_rule_config.gigabytes_downloaded.enable ? 1 : 0

  policy_id = tencentcloud_monitor_alarm_policy.cdn_monitor_policy[0].id

  dynamic "dimensions" {
    for_each = var.cdn_domains

    content {
      # For all dimensions, refer: https://intl.cloud.tencent.com/document/product/248/39565
      dimensions_json = jsonencode({
        appid  = data.tencentcloud_user_info.self.app_id
        domain = dimensions.value
      })
    }
  }
}
