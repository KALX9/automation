resource  "aws_security_group" "ssh" {
  name = "ssh"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

output "sec" {
  value = "${aws_security_group.ssh.id}"
}
