resource "aws_alb" "alb" {  
  name            = "${var.alb_name}"  
  load_balancer_type = "application"
  subnets         = [ "${var.main-public-1}" , "${var.main-public-2}" ]
  security_groups = ["${aws_security_group.example-alb-security-group.id}"]
  internal        = "false"  
  tags = {    
    Name    = "${var.alb_name}"    
  }   
}


# ALB Listener HTTP
resource "aws_alb_listener" "alb_listener" {  
  load_balancer_arn = "${aws_alb.alb.arn}"  
  port              =  80  
  protocol          = "${var.alb_listener_protocol_http}"
  
  default_action {    
    target_group_arn = "${aws_alb_target_group.alb_target_group.arn}"
    type             = "redirect"  
    
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    } 
 
 }
}

# certificate
data "aws_acm_certificate" "certificate" {
  domain   = "${var.DOMAIN}"
  statuses = ["ISSUED", "PENDING_VALIDATION"]
}

# ALB Listener HTTPS
resource "aws_alb_listener" "alb_listener_https" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port              =  443
  protocol          = "${var.alb_listener_protocol_https}"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${data.aws_acm_certificate.certificate.arn}"
    default_action {
    target_group_arn = "${aws_alb_target_group.alb_target_group.arn}"
    type             = "forward"
  }
}


# ALB Listener Rule
resource "aws_alb_listener_rule" "listener_rule" {
  depends_on   = ["aws_alb_target_group.alb_target_group"]  
  listener_arn = "${aws_alb_listener.alb_listener_https.arn}"  
  priority     =  100   
  action {    
    type             = "forward"    
    target_group_arn = "${aws_alb_target_group.alb_target_group.id}"  
  }   
  condition {    
    field  = "path-pattern"    
    values = ["${var.alb_path}"]  
  }
}

# ALB Target Group
resource "aws_alb_target_group" "alb_target_group" {  
  name     = "${var.target_group_name}"  
  port     =  80 
  protocol = "HTTP"  
  vpc_id   = "${var.vpc_id}"   
  tags = {    
    name = "${var.target_group_name}"    
  }   
  stickiness {    
    type            = "lb_cookie"    
    cookie_duration = 1800    
    enabled         = "${var.target_group_sticky}"  
  }   
  health_check {    
    healthy_threshold   = 3    
    unhealthy_threshold = 10    
    timeout             = 5    
    interval            = 10    
    path                = "${var.target_group_path}"    
    port                = "${var.target_group_port}"  
  }
}

#Autoscaling Attachment
module "auto" {
  source = "./modules/auto-scale"
}

resource "aws_autoscaling_attachment" "svc_asg_external2" {
  alb_target_group_arn   = "${aws_alb_target_group.alb_target_group.arn}"
  autoscaling_group_name = "${module.auto.auto-scale-group-name}"
}
