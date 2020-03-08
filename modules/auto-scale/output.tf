output "target_group_arn" {

 value = "${ aws_autoscaling_group.example-autoscaling.id}"

}

output "auto-scale-group-name" {
  value = "${aws_autoscaling_group.example-autoscaling.name}"
} 
