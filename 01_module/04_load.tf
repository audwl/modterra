resource "aws_lb" "mjkim_lb" {
    name = "mjkim-alb"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.mjkim_websg.id]
    subnets = [aws_subnet.mjkim_puba.id,aws_subnet.mjkim_pubc.id]
    
    tags= {
      Name = "${var.name}-alb"
    }

  
}

resource "aws_lb_target_group" "mjkim_lbtg" {
    name = "mjkim-lbtg"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.mjkim_vpc.id

    health_check {
      enabled = true
      healthy_threshold = 3
      interval = 5
      matcher = "200"
      path = "/health.html"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 2
      unhealthy_threshold = 2
    }

}
resource "aws_lb_listener" "mjkim_lblist" {
    load_balancer_arn = aws_lb.mjkim_lb.arn
    port = 80
    protocol = "HTTP"
    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.mjkim_lbtg.arn
      }

  
}
resource "aws_lb_target_group_attachment" "mjkim_lbtg_att" {
    target_group_arn = aws_lb_target_group.mjkim_lbtg.arn
    target_id = aws_instance.mjkim_web.id
    port = 80
    
}