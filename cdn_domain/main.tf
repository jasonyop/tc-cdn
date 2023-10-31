##################################################
# TencentCloud CDN
##################################################

resource "tencentcloud_cdn_domain" "cdn" {
  domain       = var.fqdn
  service_type = "web"
  area         = var.area

  cache_key {
    full_url_cache = "off"

    query_string {
      reorder = "off"
      switch  = "off"
    }
  }

  rule_cache {
    cache_time           = 5184000
    compare_max_age      = "off"
    follow_origin_switch = "off"
    ignore_cache_control = "off"
    ignore_set_cookie    = "off"
    no_cache_switch      = "off"
    re_validate          = "off"
    rule_paths = [
      "*",
    ]
    rule_type = "all"
    switch    = "on"
  }

  origin {
    origin_type          = var.origin.type
    origin_list          = var.origin.contents
    origin_pull_protocol = "http"
    server_name          = var.fqdn
  }

  https_config {
    https_switch         = "on"
    http2_switch         = "on"
    ocsp_stapling_switch = "on"
    spdy_switch          = "off"
    verify_client        = "off"

    server_certificate_config {
      certificate_id = var.ssl_cert.id
      message        = var.ssl_cert.name
    }
  }

  tags = var.tags
}
