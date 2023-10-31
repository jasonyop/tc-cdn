variable "resource_name" {
  description = "Resource name."
  type        = string
}

variable "domain_category" {
  description = "Domain category to be append as suffix for CMS alarm resources name."
  type        = string
}

variable "cdn_domains" {
  description = "List of TencentCloud CDN domains."
  type        = list(string)
}

variable "alert_rule_config" {
  description = <<EOF
Define alarm config.
  - `query_per_minute`     : Config of QPS alarm rules.
    - `enable`             : Whether to enable QPS alarm.
    - `threshold`          : Threshold for QPS count.
  - `gigabytes_downloaded` : Config of Gigabytes downloaded alarm rules.
    - `enable`             : Whether to enable Gigabytes downloaded alarm.
    - `threshold`          : Threshold for Gigabytes downloaded.
EOF
  type = object({
    query_per_minute = object({
      enable    = bool
      threshold = number
    })
    gigabytes_downloaded = object({
      enable    = bool
      threshold = number
    })
  })
}

variable "notice_ids" {
  description = "List of notification rule IDs."
  type        = list(string)
}
