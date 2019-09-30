output "osm_tile_target_group" {
  value = aws_lb_target_group.osm_tile_lb_target_group[0]
}

output "loadbalancer" {
  value = aws_lb.osm_tile_lb[0]
}

output "osm_tile_target_group_staging" {
  value = aws_lb_target_group.osm_tile_lb_target_group[1]
}

output "loadbalancer_staging" {
  value = aws_lb.osm_tile_lb[1]
}
