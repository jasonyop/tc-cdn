# variable "ssl_certs" {
#   description = "SSL Certificates list."
#   type        = map(map(string))
# }

variable "domains" {
  description = <<EOF
Domains list.
  - `domain`     : Root domain.
  - `tags`       : Root domain's tags.
  - `subdomains` : List of subdomains.
    - `name`     : Subdomain.
    - `tags`     : Subdomain's tags.
EOF
  type = list(object({
    domain = string
    tags   = map(string)
    subdomains = list(object({
      name = string
      tags = map(string)
    }))
  }))
}

variable "filter" {
  description = <<EOF
Domains filter.
  - `domain_country`  : Domain country.
  - `be_app_category` : Backend application category.
  - `devops_category` : DevOps category.
EOF
  type = object({
    domain_country  = string
    be_app_category = string
    devops_category = string
  })
}
