resource "aws_instance" "myvm" {
    ami = var.AMIS[var.REGION]
    instance_type = "t2.micro"
}