resource "tencentcloud_cam_policy" "tencentcloud_cam_policy_devops_support_cdn" {
  name     = "${local.resource_name}-devops-support"
  document = <<EOF
  {
    "version": "2.0",
    "statement": [
      {
        "effect": "allow",
        "action": [
            "cdn:CheckDomainIsSuperior",
            "cdn:Describe*",
            "cdn:List*",
            "cdn:SearchClsLog"
        ],
        "resource": [
          "qcs::cdn::*:domain/*"
        ]
      },
      {
        "effect": "allow",
        "action": [
          "cdn:PurgePathCache",
          "cdn:PurgeUrlsCache",
          "cdn:PushUrlsCache"
        ],
        "resource": [
          "*"
        ]
      }
    ]
  }
  EOF
}
