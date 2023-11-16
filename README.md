tencentcloud-web-server-cdn
===========================

This is a Terraform module to create CDN (Content Delivery Network) for web-server use case in TencentCloud.

## Available Scenario for Testing

- basic/default

    This scenarios will run using domains from country `default`.
    Working directory is `examples/basic/default`.

- basic/cn

    This scenarios will run using domains from country `cn`.
    Working directory is `examples/basic/cn`.

- basic/th

    This scenarios will run using domains from country `th`.
    Working directory is `examples/basic/th`.

## Known Issues

1. TencentCloud
    - CDN cannot be used with WILDCARD domain. For each sub domain,
      a new resource must be created.
    - CDN currently does not support to configure referer restriction
      in terraform.

## Input Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cloud\_creds | Cloud credentials.<br>  - `tencentcloud` : TencentCloud credentials.<br>    - `secret_id`  : TencentCloud secret ID.<br>    - `secret_key` : TencentCloud secret key. | <pre>object({<br>    tencentcloud = object({<br>      secret_id  = string<br>      secret_key = string<br>    })<br>  })</pre> | n/a | yes |
| module\_info | Map of module's info details.<br>  - `brand`           : Product brand.<br>  - `env`             : Application environment.<br>  - `be_app_category` : Backend application category.<br>  - `domain_country`  : Domain country, default to `default`. | <pre>object({<br>    brand           = string<br>    env             = string<br>    be_app_category = string<br>    domain_country  = optional(string, "default")<br>  })</pre> | n/a | yes |
| module\_tmpl | Module template output format.<br>  - `resource_name`          : Template for resource naming.<br>  - `module_name`            : Specify full name used for module.<br>  - `ssl_cert_resource_name` : Template for TencentCloud SSL resource naming.<br>  - `terraform_vault_path`   : Template for Terraform module's vault path.<br>  - `ssl_cert_vault_path`    : Template for ssl certificate vault path. | <pre>object({<br>    resource_name          = optional(string, "{brand}-{env}-web-server-cdn-{domain_country}")<br>    module_name            = optional(string, "{brand}-{env}-tencentcloud-web-server-cdn-{domain_country}")<br>    ssl_cert_resource_name = optional(string, "{brand}-{env}-web-server-cdn")<br>    terraform_vault_path   = optional(string, "devops/terraform/{brand}/{env}/{be_app_category}/tencentcloud-web-server-cdn-{domain_country}")<br>    ssl_cert_vault_path    = optional(string, "devops/ssl_cert/{brand}/{env}/zerossl")<br>  })</pre> | n/a | yes |
| cdn\_domains | TencentCloud CDN Domains configuration.<br>  - `region`           : TencentCloud CDN region.<br>  - `origin`           : TencentCloud CDN origin.<br>    - `source_type`    : TencentCloud CDN origin type.<br>    - `source_content` : TencentCloud CDN origin content. | <pre>object({<br>    region = string<br>    origin = object({<br>      source_type    = string<br>      source_content = list(string)<br>    })<br>  })</pre> | n/a | yes |
| games | Configuration of games subdomains for CDN.<br>  - `games_entry`              : Configuration of games entry subdomains for CDN.<br>    - `enable`                 : Define whether to create TencentCloud CDN.<br>    - `alarm`                  : Define the alarm config.<br>      - `query_per_minute`     : Config of QPS alarm rules.<br>        - `enable`             : Whether to enable QPS alarm.<br>        - `threshold`          : Threshold for QPS count.<br>      - `gigabytes_downloaded` : Config of Gigabytes downloaded alarm rules.<br>        - `enable`             : Whether to enable Gigabytes downloaded alarm.<br>        - `threshold`          : Threshold for Gigabytes downloaded.<br>  - `games_resources`          : Configuration of games resources subdomains for CDN.<br>    - `enable`                 : Define whether to create TencentCloud CDN.<br>    - `alarm`                  : Define the alarm config.<br>      - `query_per_minute`     : Config of QPS alarm rules.<br>        - `enable`             : Whether to enable QPS alarm.<br>        - `threshold`          : Threshold for QPS count.<br>      - `gigabytes_downloaded` : Config of Gigabytes downloaded alarm rules.<br>        - `enable`             : Whether to enable Gigabytes downloaded alarm.<br>        - `threshold`          : Threshold for Gigabytes downloaded.<br>  - `app`                      : Configuration of app subdomains for CDN.<br>    - `enable`                 : Define whether to create TencentCloud CDN.<br>    - `alarm`                  : Define the alarm config.<br>      - `query_per_minute`     : Config of QPS alarm rules.<br>        - `enable`             : Whether to enable QPS alarm.<br>        - `threshold`          : Threshold for QPS count.<br>      - `gigabytes_downloaded` : Config of Gigabytes downloaded alarm rules.<br>        - `enable`             : Whether to enable Gigabytes downloaded alarm.<br>        - `threshold`          : Threshold for Gigabytes downloaded.<br>  - `public`                   : Configuration of public subdomains for CDN.<br>    - `enable`                 : Define whether to create TencentCloud CDN.<br>    - `alarm`                  : Define the alarm config.<br>      - `query_per_minute`     : Config of QPS alarm rules.<br>        - `enable`             : Whether to enable QPS alarm.<br>        - `threshold`          : Threshold for QPS count.<br>      - `gigabytes_downloaded` : Config of Gigabytes downloaded alarm rules.<br>        - `enable`             : Whether to enable Gigabytes downloaded alarm.<br>        - `threshold`          : Threshold for Gigabytes downloaded. | <pre>object({<br>    games_entry = optional(object({<br>      enable = bool<br><br>      alarm = object({<br>        query_per_minute = object({<br>          enable    = bool<br>          threshold = number<br>        })<br>        gigabytes_downloaded = object({<br>          enable    = bool<br>          threshold = number<br>        })<br>      })<br>    }))<br><br>    games_resources = optional(object({<br>      enable = bool<br><br>      alarm = object({<br>        query_per_minute = object({<br>          enable    = bool<br>          threshold = number<br>        })<br>        gigabytes_downloaded = object({<br>          enable    = bool<br>          threshold = number<br>        })<br>      })<br>    }))<br><br>    app = optional(object({<br>      enable = bool<br><br>      alarm = object({<br>        query_per_minute = object({<br>          enable    = bool<br>          threshold = number<br>        })<br>        gigabytes_downloaded = object({<br>          enable    = bool<br>          threshold = number<br>        })<br>      })<br>    }))<br><br>    public = optional(object({<br>      enable = bool<br><br>      alarm = object({<br>        query_per_minute = object({<br>          enable    = bool<br>          threshold = number<br>        })<br>        gigabytes_downloaded = object({<br>          enable    = bool<br>          threshold = number<br>        })<br>      })<br>    }))<br>  })</pre> | n/a | yes |
| landing | Configuration of landing be-app-category for CDN.<br>  - `backoffice`                : Backoffice config.<br>    - `enable`                  : Define whether to create TencentCloud CDN.<br>    - `alarm`                   : Define the alarm config.<br>      - `query_per_minute`      : Config of QPS alarm rules.<br>        - `enable`              : Whether to enable QPS alarm.<br>        - `threshold`           : Threshold for QPS count.<br>      - `gigabytes_downloaded`  : Config of Gigabytes downloaded alarm rules.<br>        - `enable`              : Whether to enable Gigabytes downloaded alarm.<br>        - `threshold`           : Threshold for Gigabytes downloaded. | <pre>object({<br>    backoffice = optional(object({<br>      enable = bool<br><br>      alarm = object({<br>        query_per_minute = object({<br>          enable    = bool<br>          threshold = number<br>        })<br>        gigabytes_downloaded = object({<br>          enable    = bool<br>          threshold = number<br>        })<br>      })<br>    }))<br>  })</pre> | n/a | yes |
| crm | Configuration of crm be-app-category for CDN.<br>  - `backoffice`                : Backoffice config.<br>    - `enable`                  : Define whether to create TencentCloud CDN.<br>    - `alarm`                   : Define the alarm config.<br>      - `query_per_minute`      : Config of QPS alarm rules.<br>        - `enable`              : Whether to enable QPS alarm.<br>        - `threshold`           : Threshold for QPS count.<br>      - `gigabytes_downloaded`  : Config of Gigabytes downloaded alarm rules.<br>        - `enable`              : Whether to enable Gigabytes downloaded alarm.<br>        - `threshold`           : Threshold for Gigabytes downloaded. | <pre>object({<br>    backoffice = optional(object({<br>      enable = bool<br><br>      alarm = object({<br>        query_per_minute = object({<br>          enable    = bool<br>          threshold = number<br>        })<br>        gigabytes_downloaded = object({<br>          enable    = bool<br>          threshold = number<br>        })<br>      })<br>    }))<br>  })</pre> | n/a | yes |
| cdn\_vendor | TencentCloud CDN vendor config. | <pre>object({<br>    allow_create_cam_user = bool<br>  })</pre> | n/a | yes |
| notice\_ids | List of Notice IDs for TencentCloud Monitor Alarm. | `list(string)` | n/a | yes |
| vault\_approle\_cidrs\_for\_game\_deploy | List of cidr that allow instances to access to game-deploy appRoles. | `list(string)` | n/a | yes |

## Outputs Values

| Name | Description |
|------|-------------|
| cloud\_monitor\_access\_key | TencentCloud CDN CloudMonitor CAM user's access key id for Grafana CDN dashboard. |
| cloud\_monitor\_secret\_key | TencentCloud CDN CloudMonitor CAM user's access key secret for Grafana CDN dashboard. |
| game\_deploy\_access\_key | TencentCloud CDN CAM user's access key id for game deploy. |
| game\_deploy\_secret\_key | TencentCloud CDN CAM user's access key secret for game deploy. |
