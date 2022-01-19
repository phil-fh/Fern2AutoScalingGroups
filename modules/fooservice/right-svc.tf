resource "aws_launch_configuration" "fooservice-right" {
  image_id = data.aws_ami.amazon-2.image_id
  instance_type = "t3.micro"
  user_data = base64encode(templatefile("${path.module}/templates/init_node.tpl", { container_image = "phil4fh/rightservice", container_version = var.container_version} ))
  security_groups = [aws_security_group.ingress-all-3000.id]
  name_prefix = "${var.fooservice_name}-fooservice-right"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg-fooservice-right" {
  availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]
  desired_capacity   = var.desired_instances
  max_size           = var.max_instances
  min_size           = var.min_instances
  name = "${var.fooservice_name}-right-asg"

  launch_configuration = aws_launch_configuration.fooservice-right.name

  health_check_type    = "ELB"
  load_balancers = [
    aws_elb.right_elb.id
  ]
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }

  tag {
    key                 = "Name"
    value               = "${var.fooservice_name}-fooservice-right"
    propagate_at_launch = true
  }
}

resource "aws_elb" "right_elb" {
  name = "${var.fooservice_name}-right-elb"
  availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]
  security_groups = [
    aws_security_group.elb_http_3000.id
  ]

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:3000/"
  }

  listener {
    lb_port = 3000
    lb_protocol = "http"
    instance_port = "3000"
    instance_protocol = "http"
  }

}