output "instance_ip" {
  value = data.aws_instance.web.public_ip
}

