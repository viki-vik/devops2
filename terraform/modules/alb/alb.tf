data "aws_route53_zone" "this" {
  name = var.site_zone_name
}

locals {
  alb_name   = "devops2-alb"
  account_id = 0123456789
}

module "alb_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.12.0"

  name            = "devops2-alb-sg"
  use_name_prefix = false

  vpc_id              = var.vpc_id
  ingress_cidr_blocks = [var.additional_ingress_cidrs]
  ingress_rules       = ["http-80-tcp", "https-443-tcp"]
  egress_rules        = ["all-all"]

  tags = merge(module.common.default_tags, {
    Name    = "alb-sg"
    Purpose = "$ALB security group"
  })
}

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "6.10.0"

  name = local.alb_name

  load_balancer_type = "application"
  internal           = true
  desync_mitigation_mode = "defensive"

  vpc_id          = var.vpc_id
  subnets         = var.subnet_ids
  security_groups = flatten([module.alb_sg.security_group_id, var.additional_security_groups])

  target_groups = [
    {
      name             = var.tg_name
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      health_check = {
        enabled             = true // Health check enabled must be true for target groups with target type 'instance'
        interval            = 300  // 300 - max possible internal
        path                = "/"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 10
        protocol            = "HTTP"
        matcher             = "200-399"
      }
    }
  ]


  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = var.certificate_arn
      ssl_policy         = var.application_lb_ssl_negotiation_policy
      target_group_index = 0
    }
  ]

  http_tcp_listeners = [
    {
      port        = 80
      protocol    = "HTTP"
      action_type = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  ]

  tags = merge(module.common.default_tags, {
    Purpose = "ALB"
  })

  target_group_tags = merge(module.common.default_tags, {
    Purpose = "ALB target group"
  })
}

resource "aws_route53_record" "this" {
  name    = var.domain_name
  zone_id = data.aws_route53_zone.this[0].zone_id

  type = "A"
  alias {
    name                   = module.alb.lb_dns_name
    zone_id                = module.alb.lb_zone_id
    evaluate_target_health = false
  }
}