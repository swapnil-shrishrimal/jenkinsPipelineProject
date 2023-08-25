resource "aws_instance" "deployment" {
    ami = "ami-08a52ddb321b32a8c"
    instance_type = "t2.micro" // t2.micro, t2.small ..
    user_data = file("user_data.sh")
    tags = {
        Name = "Deployment Server"
    }
    vpc_security_group_ids = ["sg-045c84b3a0a181ac8"]
}
