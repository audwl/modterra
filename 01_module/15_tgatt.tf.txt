resource "aws_lb_target_group_attachment" "mjkim_lbtg_att" {
    target_group_arn = aws_lb_target_group.mjkim_lbtg.arn
    target_id = aws_instance.mjkim_weba.id
    port = 80
    
}