resource "aws_key_pair" "mykey"{
    key_name = "naveenkey"
    public_key = file(var.PATH_TO_PUBLIC_KEY)

}

resource "aws_instance" "keyvm"{
    ami = var.AMIS[var.REGION]
    instance_type = "t2.micro"
    key_name = aws_key_pair.mykey.key_name

    provisioner "file"{
        source = "script.sh"
        destination= "/tmp/script.sh"
    }
    provisioner "remote-exec"{
        inline = [
            "chmod +x script.sh",
            "sudo sh /tmp/script.sh"
        ]
    }

    connection{
        host = coalesce(self.public_ip, self.private_ip)
        type = "ssh"
        user = var.USERNAME
        private_key = file(var.PATH_TO_PRIVATE_KEY)
    }

}