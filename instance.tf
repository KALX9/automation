resource "aws_instance" "naveenvm" {
    ami = var.AMIS[var.REGION]
    instance_type = "t2.micro"
    provisioner "local-exec"{
        command = "echo ${aws_instance.naveenvm.private_ip}>>details.txt"
    }
     provisioner "local-exec"{
        command = "echo ${aws_instance.naveenvm.availability_zone}>>details.txt"
    }
}
output "ip"{
    value = aws_instance.naveenvm.public_ip
}
output "host"{
    value = aws_instance.naveenvm.host_id

}
output "state"{
    value = aws_instance.naveenvm.instance_state
}