output "cloud_monitor_access_key" {
  description = "TencentCloud CDN CloudMonitor CAM user's access key id for Grafana CDN dashboard."
  value       = try(tencentcloud_cam_user.cloud_monitor[0].secret_id, "")
  sensitive   = true
}

output "cloud_monitor_secret_key" {
  description = "TencentCloud CDN CloudMonitor CAM user's access key secret for Grafana CDN dashboard."
  value       = try(tencentcloud_cam_user.cloud_monitor[0].secret_key, "")
  sensitive   = true
}

output "game_deploy_access_key" {
  description = "TencentCloud CDN CAM user's access key id for game deploy."
  value       = try(tencentcloud_cam_user.game_deploy_user[0].secret_id, "")
  sensitive   = true
}

output "game_deploy_secret_key" {
  description = "TencentCloud CDN CAM user's access key secret for game deploy."
  value       = try(tencentcloud_cam_user.game_deploy_user[0].secret_key, "")
  sensitive   = true
}
