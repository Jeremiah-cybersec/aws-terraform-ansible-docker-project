output "instance_ip" {
  value = data.aws_instance.web.public_ip
}
output "instance_id" {
  value = data.aws_instance.web.id
}

