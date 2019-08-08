output "osm_tile_target_group" {
  value = aws_lb_target_group.osm_tile_lb_target_group
}

output "loadbalancer" {
  value = aws_lb.osm_tile_lb
}
