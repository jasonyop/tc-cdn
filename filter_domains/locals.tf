locals {
  filtered_domains = merge([
    for domain in var.domains : {
      for subdomain in domain.subdomains :
      "${subdomain.name}.${domain.domain}" => {
        domain    = domain.domain
        subdomain = subdomain.name

        tags = merge(
          { for tag_key, tag_value in domain.tags : replace(tag_key, "-", "_") => tag_value if contains(["active"], tag_key) },
          { for tag_key, tag_value in subdomain.tags : replace(tag_key, "-", "_") => tag_value }
        )

        # non-cn will not have icp tag.
        area = try(domain.tags.icp, false) ? "global" : "overseas"

      } if subdomain.tags["be-app-category"] == var.filter.be_app_category && subdomain.tags["devops-category"] == var.filter.devops_category
    } if try(domain.tags.country, "default") == var.filter.domain_country && try(domain.tags.icp, true)
  ]...)
}
