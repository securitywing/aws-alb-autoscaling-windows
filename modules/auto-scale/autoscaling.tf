resource "aws_launch_configuration" "example-launchconfig" {
  name_prefix          =  "${var.name_prefix}_launchconfig"
  image_id             = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type        = "t3.medium"
  key_name             = "${aws_key_pair.example-keypair.key_name}"
  security_groups      = ["${aws_security_group.example-security-group.id}"]
   root_block_device  {
      volume_size = "30"
      volume_type = "gp2"
      encrypted = true
    }
  
  user_data = <<EOF
  <powershell>
  Install-WindowsFeature -name Web-Server -IncludeManagementTools
  </powershell>
  EOF
}

resource "aws_autoscaling_group" "example-autoscaling" {
  name                 = "${var.name_prefix}-autoscaling"
  vpc_zone_identifier  = ["${var.main-private-1}", "${var.main-private-2}"]
  launch_configuration = "${aws_launch_configuration.example-launchconfig.name}"
  min_size             = 2
  max_size             = 3
  health_check_grace_period = 300
  health_check_type = "EC2"
  force_delete = true

  tag {
      key = "Name"
      value = "webserver-01"
      propagate_at_launch = true
  }

  tag {
    key                 = "env"
    value               = "uat"
    propagate_at_launch = true
  }

}

