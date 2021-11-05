resource "aws_ami_from_instance" "mjkim_ami" {
  name                    = "${var.name}-ami"
  source_instance_id      = aws_instance.mjkim_web.id
  depends_on = [
    aws_instance.mjkim_web
  ]
    lifecycle {
    create_before_destroy = true
  }
}
resource "aws_launch_configuration" "mjkim_lacf" {
    name = "${var.name}-web"
    image_id =  aws_ami_from_instance.mjkim_ami.id
    instance_type = var.instance
    iam_instance_profile = "admin-role"
    security_groups = [aws_security_group.mjkim_websg.id]
    key_name = var.key
    user_data = <<-EOF
                #!/bin/bash
                systemctl start httpd
                systemctl enable httpd
                EOF
  lifecycle {
    create_before_destroy = true
    
  }
}
resource "aws_placement_group" "mjkim_pg" {
    name = "${var.name}-pg"
    strategy = var.strategy
}
resource "aws_autoscaling_group" "mjkim_atsg" {
    name = "${var.name}_atsg"
    min_size = 2
    max_size = 8
    health_check_grace_period = 300
    health_check_type = "ELB"
    desired_capacity = 2
    force_delete = true
    launch_configuration = aws_launch_configuration.mjkim_lacf.name
    vpc_zone_identifier   = [aws_subnet.mjkim_pub[0].id,aws_subnet.mjkim_pub[1].id]
}
resource "aws_autoscaling_attachment" "mjkim_atatt" {
  autoscaling_group_name = aws_autoscaling_group.mjkim_atsg.id
  alb_target_group_arn = aws_lb_target_group.mjkim_lbtg.arn
}
