variable "fqdn" {
  description = "FQDN for creating TencentCloud CDN."
  type        = string
}

variable "area" {
  description = "Define CDN area. Valid options: mainland, overseas, global."
  type        = string

  validation {
    condition     = var.area == "mainland" || var.area == "overseas" || var.area == "global"
    error_message = "Error: Invalid input! Availble options: mainland, overseas, global."
  }
}

variable "origin" {
  description = <<EOF
Define list of origins for CDN.
  - `type`     : CDN origin type.
  - `contents` : CDN origin contents.
EOF
  type = object({
    type     = string
    contents = list(string)
  })
}

variable "tags" {
  description = "Define CDN Tags."
  type        = map(string)
}

variable "ssl_cert" {
  sensitive   = true
  description = <<EOF
Define TencentCloud SSL certificate.
  - `id`   : Cert ID.
  - `name` : Cert name.
EOF
  type = object({
    id   = string
    name = string
  })
}
