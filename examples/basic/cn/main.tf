locals {
  brand       = "sige"
  environment = "basic"

  alarm = {
    query_per_minute = {
      enable    = true
      threshold = 6000
    }
    gigabytes_downloaded = {
      enable    = true
      threshold = 1
    }
  }
}

module "tencentcloud_cdn" {
  source = "../../../"

  cloud_creds = {
    tencentcloud = {
      secret_id  = data.vault_generic_secret.tencentcloud_dev.data["TENCENTCLOUD_SECRET_ID"]
      secret_key = data.vault_generic_secret.tencentcloud_dev.data["TENCENTCLOUD_SECRET_KEY"]
    }
  }

  module_info = {
    brand           = local.brand
    env             = local.environment
    be_app_category = "generic"
    domain_country  = "cn"
  }
  module_tmpl = {
    ssl_cert_vault_path = "devops/ssl_cert/sige/test/zerossl"
  }

  cdn_domains = {
    region = "ap-hongkong",
    origin = {
      source_type    = "domain",
      source_content = ["google.com"]
    }
  }

  million_plan = {
    landing = {}

    games = {
      games_entry = {
        enable = true

        alarm = local.alarm
      }

      games_resources = {
        enable = true

        alarm = local.alarm
      }

      app = {
        enable = true

        alarm = local.alarm
      }

      public = {
        enable = true

        alarm = local.alarm
      }
    }
  }

  crm = {}

  cdn_vendor = {
    allow_create_cam_user = true
  }

  notice_ids = []

  vault_approle_cidrs_for_game_deploy = ["0.0.0.0/0"]
}
