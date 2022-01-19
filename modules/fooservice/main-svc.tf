resource "aws_launch_configuration" "fooservice-front" {
  image_id = data.aws_ami.amazon-2.image_id
  instance_type = "t3.micro"
  user_data = base64encode(templatefile("${path.module}/templates/init_front.tpl", { container_image = "phil4fh/frontservice", container_version = var.container_version, left_host = aws_elb.left_elb.dns_name, right_host = aws_elb.right_elb.dns_name } ))
  security_groups = [aws_security_group.ingress-all-http.id]
  name_prefix = "${var.fooservice_name}-fooservice-front"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg-fooservice-main" {
  availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]
  desired_capacity   = var.desired_instances
  max_size           = var.max_instances
  min_size           = var.min_instances
  name = "${var.fooservice_name}-main-asg"

  launch_configuration = aws_launch_configuration.fooservice-front.name

  health_check_type    = "ELB"
  load_balancers = [
    aws_elb.main_elb.id
  ]

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
      instance_warmup = "60"
    }
    triggers = ["tag"]
  }

  tag {
    key                 = "Name"
    value               = "${var.fooservice_name}-fooservice-main"
    propagate_at_launch = true
  }
}

resource "aws_elb" "main_elb" {
  name = "${var.fooservice_name}-main-elb"
  availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]
  security_groups = [
    aws_security_group.elb_http.id
  ]

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:8080/"
  }

  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "8080"
    instance_protocol = "http"
  }
}