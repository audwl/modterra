resource "aws_lb" "mjkim_lb" {
    name = "${var.name}-alb"
    internal = false
    load_balancer_type = var.loac_type
    security_groups = [aws_security_group.mjkim_websg.id]
    subnets = [aws_subnet.mjkim_pub[0].id, aws_subnet.mjkim_pub[1].id]
    
    tags= {
      Name = "${var.name}-alb"
    }

  
}

resource "aws_lb_target_group" "mjkim_lbtg" {
    name = "${var.name}-lbtg"
    port = var.http_port
    protocol = var.prot_http
    vpc_id = aws_vpc.mjkim_vpc.id

    health_check {
      enabled = true
      healthy_threshold = 3
      interval = 5
      matcher = "200"
      path = "/health.html"
      port = "traffic-port"
      protocol = var.prot_http
      timeout = 2
      unhealthy_threshold = 2
    }

}
resource "aws_lb_listener" "mjkim_lblist" {
  count = 2
    load_balancer_arn = aws_lb.mjkim_lb[count.index].arn
    port = var.http_port
    protocol = var.prot_http
    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.mjkim_lbtg.arn
      }

  
}
resource "aws_lb_target_group_attachment" "mjkim_lbtg_att" {
    target_group_arn = aws_lb_target_group.mjkim_lbtg.arn
    target_id = aws_instance.mjkim_web.id
    port = var.http_port
    
}
