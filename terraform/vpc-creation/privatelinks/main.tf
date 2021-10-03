#######local ############

locals {
  
    autoscaling_name = "${var.vpc_name}-ASG"
    launch_configuration_name = "${var.vpc_name}-LC"
    target_group_name = var.target_group_name
    nlb_name = var.nlb_name
  }
 
#### Data ############
data "aws_security_group" "existing" {
  vpc_id = var.vpc_id

 filter {
    name   = "group-name"
    values = ["ssh-ts-customer"]
  }
 } 


####### Autoscaling ############
resource "aws_autoscaling_group" "autoscaling_group_config" {
  name                      = local.autoscaling_name
  max_size                  = 3
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = 3
  force_delete              = true
  vpc_zone_identifier       = var.private_subnet_ids
  target_group_arns         = ["${aws_lb_target_group.customer_tg.arn}"]
  launch_configuration      = aws_launch_configuration.customer_lc.name
  capacity_rebalance        = true

  dynamic "tag" {
    for_each = var.tags
    content {
      key    =  tag.key
      value   =  tag.value
      propagate_at_launch =  true
    }
  }
  tag {
    key                 = "Name"
    value               = var.instance_name
    propagate_at_launch = true
  }
}



###### Launch Config ###########
resource "aws_launch_configuration" "customer_lc" {
  name            = local.launch_configuration_name
  image_id        = data.aws_ami.ubuntu.id
  instance_type   = var.instance_type
  security_groups = var.secgrp == false ? ["${data.aws_security_group.existing.id}"] : ["${aws_security_group.secgrp_ec2[0].id}"]
  key_name        = var.sshkeypair
  user_data       = file("${path.module}/userdata.sh")
  
  
  lifecycle {
    ignore_changes = [image_id]
  }

}

### NLB #######
resource "aws_lb" "customer_nlb" {
  name               = local.nlb_name
  internal           = true
  load_balancer_type = "network"
  subnets            = var.private_subnet_ids
  tags     = merge(var.tags, map("Name", "${var.vpc_name}-NLB",))
}


resource "aws_lb_target_group" "customer_tg" {
  name     = local.target_group_name
  port     = 443
  protocol = "TCP"
  vpc_id   = var.vpc_id
  tags     = merge(var.tags, map("Name", "${var.vpc_name}-TG",))

  health_check {
    healthy_threshold   = 5
    unhealthy_threshold = 5
    interval            = 10
  }
}


resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.customer_nlb.arn
  port              = "443"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.customer_tg.arn
  }
}



########### EC2 #######
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_security_group" "secgrp_ec2" {
  count       = var.secgrp == true ? 1 : 0
  name        = "ssh-ts-customer"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "ALL Traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags     = merge(var.tags, map("Name", "ssh-customer",))
}

#### Private links ##

resource "aws_vpc_endpoint_service" "customer_1" {
  acceptance_required        = false
  network_load_balancer_arns = [aws_lb.customer_nlb.arn]
  allowed_principals         = [var.source_arn]
  tags     = merge(var.tags, map("Name", "${var.vpc_name}-ES",))
}
