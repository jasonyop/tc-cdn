variable "cloud_creds" {
  description = <<EOF
Cloud credentials.
  - `tencentcloud` : TencentCloud credentials.
    - `secret_id`  : TencentCloud secret ID.
    - `secret_key` : TencentCloud secret key.
EOF
  type = object({
    tencentcloud = object({
      secret_id  = string
      secret_key = string
    })
  })
}

variable "module_info" {
  description = <<EOF
Map of module's info details.
  - `brand`           : Product brand.
  - `env`             : Application environment.
  - `be_app_category` : Backend application category.
  - `domain_country`  : Domain country, default to `default`.
EOF
  type = object({
    brand           = string
    env             = string
    be_app_category = string
    domain_country  = optional(string, "default")
  })
}

variable "module_tmpl" {
  description = <<EOF
Module template output format.
  - `resource_name`          : Template for resource naming.
  - `module_name`            : Specify full name used for module.
  - `ssl_cert_resource_name` : Template for TencentCloud SSL resource naming.
  - `terraform_vault_path`   : Template for Terraform module's vault path.
  - `ssl_cert_vault_path`    : Template for ssl certificate vault path.
EOF
  type = object({
    resource_name          = optional(string, "{brand}-{env}-web-server-cdn-{domain_country}")
    module_name            = optional(string, "{brand}-{env}-tencentcloud-web-server-cdn-{domain_country}")
    ssl_cert_resource_name = optional(string, "{brand}-{env}-web-server-cdn")
    terraform_vault_path   = optional(string, "devops/terraform/{brand}/{env}/{be_app_category}/tencentcloud-web-server-cdn-{domain_country}")
    ssl_cert_vault_path    = optional(string, "devops/ssl_cert/{brand}/{env}/zerossl")
  })
}

variable "cdn_domains" {
  description = <<EOF
TencentCloud CDN Domains configuration.
  - `region`           : TencentCloud CDN region.
  - `origin`           : TencentCloud CDN origin.
    - `source_type`    : TencentCloud CDN origin type.
    - `source_content` : TencentCloud CDN origin content.
EOF
  type = object({
    region = string
    origin = object({
      source_type    = string
      source_content = list(string)
    })
  })
}

variable "games" {
  description = <<EOF
Configuration of games subdomains for CDN.
  - `games_entry`              : Configuration of games entry subdomains for CDN.
    - `enable`                 : Define whether to create TencentCloud CDN.
    - `alarm`                  : Define the alarm config.
      - `query_per_minute`     : Config of QPS alarm rules.
        - `enable`             : Whether to enable QPS alarm.
        - `threshold`          : Threshold for QPS count.
      - `gigabytes_downloaded` : Config of Gigabytes downloaded alarm rules.
        - `enable`             : Whether to enable Gigabytes downloaded alarm.
        - `threshold`          : Threshold for Gigabytes downloaded.
  - `games_resources`          : Configuration of games resources subdomains for CDN.
    - `enable`                 : Define whether to create TencentCloud CDN.
    - `alarm`                  : Define the alarm config.
      - `query_per_minute`     : Config of QPS alarm rules.
        - `enable`             : Whether to enable QPS alarm.
        - `threshold`          : Threshold for QPS count.
      - `gigabytes_downloaded` : Config of Gigabytes downloaded alarm rules.
        - `enable`             : Whether to enable Gigabytes downloaded alarm.
        - `threshold`          : Threshold for Gigabytes downloaded.
  - `app`                      : Configuration of app subdomains for CDN.
    - `enable`                 : Define whether to create TencentCloud CDN.
    - `alarm`                  : Define the alarm config.
      - `query_per_minute`     : Config of QPS alarm rules.
        - `enable`             : Whether to enable QPS alarm.
        - `threshold`          : Threshold for QPS count.
      - `gigabytes_downloaded` : Config of Gigabytes downloaded alarm rules.
        - `enable`             : Whether to enable Gigabytes downloaded alarm.
        - `threshold`          : Threshold for Gigabytes downloaded.
  - `public`                   : Configuration of public subdomains for CDN.
    - `enable`                 : Define whether to create TencentCloud CDN.
    - `alarm`                  : Define the alarm config.
      - `query_per_minute`     : Config of QPS alarm rules.
        - `enable`             : Whether to enable QPS alarm.
        - `threshold`          : Threshold for QPS count.
      - `gigabytes_downloaded` : Config of Gigabytes downloaded alarm rules.
        - `enable`             : Whether to enable Gigabytes downloaded alarm.
        - `threshold`          : Threshold for Gigabytes downloaded.
EOF
  type = object({
    games_entry = optional(object({
      enable = bool

      alarm = object({
        query_per_minute = object({
          enable    = bool
          threshold = number
        })
        gigabytes_downloaded = object({
          enable    = bool
          threshold = number
        })
      })
    }))

    games_resources = optional(object({
      enable = bool

      alarm = object({
        query_per_minute = object({
          enable    = bool
          threshold = number
        })
        gigabytes_downloaded = object({
          enable    = bool
          threshold = number
        })
      })
    }))

    app = optional(object({
      enable = bool

      alarm = object({
        query_per_minute = object({
          enable    = bool
          threshold = number
        })
        gigabytes_downloaded = object({
          enable    = bool
          threshold = number
        })
      })
    }))

    public = optional(object({
      enable = bool

      alarm = object({
        query_per_minute = object({
          enable    = bool
          threshold = number
        })
        gigabytes_downloaded = object({
          enable    = bool
          threshold = number
        })
      })
    }))
  })
}

variable "landing" {
  description = <<EOF
Configuration of landing be-app-category for CDN.
  - `backoffice`                : Backoffice config.
    - `enable`                  : Define whether to create TencentCloud CDN.
    - `alarm`                   : Define the alarm config.
      - `query_per_minute`      : Config of QPS alarm rules.
        - `enable`              : Whether to enable QPS alarm.
        - `threshold`           : Threshold for QPS count.
      - `gigabytes_downloaded`  : Config of Gigabytes downloaded alarm rules.
        - `enable`              : Whether to enable Gigabytes downloaded alarm.
        - `threshold`           : Threshold for Gigabytes downloaded.
EOF
  type = object({
    backoffice = optional(object({
      enable = bool

      alarm = object({
        query_per_minute = object({
          enable    = bool
          threshold = number
        })
        gigabytes_downloaded = object({
          enable    = bool
          threshold = number
        })
      })
    }))
  })
}

variable "crm" {
  description = <<EOF
Configuration of crm be-app-category for CDN.
  - `backoffice`                : Backoffice config.
    - `enable`                  : Define whether to create TencentCloud CDN.
    - `alarm`                   : Define the alarm config.
      - `query_per_minute`      : Config of QPS alarm rules.
        - `enable`              : Whether to enable QPS alarm.
        - `threshold`           : Threshold for QPS count.
      - `gigabytes_downloaded`  : Config of Gigabytes downloaded alarm rules.
        - `enable`              : Whether to enable Gigabytes downloaded alarm.
        - `threshold`           : Threshold for Gigabytes downloaded.
EOF
  type = object({
    backoffice = optional(object({
      enable = bool

      alarm = object({
        query_per_minute = object({
          enable    = bool
          threshold = number
        })
        gigabytes_downloaded = object({
          enable    = bool
          threshold = number
        })
      })
    }))
  })
}

variable "cdn_vendor" {
  description = "TencentCloud CDN vendor config."
  type = object({
    allow_create_cam_user = bool
  })
}

variable "notice_ids" {
  description = "List of Notice IDs for TencentCloud Monitor Alarm."
  type        = list(string)
}

variable "vault_approle_cidrs_for_game_deploy" {
  description = "List of cidr that allow instances to access to game-deploy appRoles."
  type        = list(string)
}
