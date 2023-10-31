data "st-utilities_module_tmpl" "template" {
  module_info = var.module_info
  module_tmpl = var.module_tmpl
}

data "external" "web_server_domains" {
  program = [
    "docker", "run",
    "--rm",
    "--pull", "always",
    "harbor.sige.la/devops-cr/20twenty:latest",
    "get-customer-domains",
    "--brand", var.module_info.brand,
    "--env", var.module_info.env,
    "--devops-app", "web-server",
    "--format", "terraform"
  ]
}
