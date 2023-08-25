resource "aws_instance" "deployment" {
    ami = "ami-08a52ddb321b32a8c"
    instance_type = "t2.micro" // t2.micro, t2.small ..
    user_data = <<EOF  
#!/bin/bash
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io -y
sudo usermod -aG docker ec2-user
sudo systemctl start docker
docker run -d -p 80:80 swapnil19/angular-app
EOF
    tags = {
        Name = "Deployment Server"
    }
    vpc_security_group_ids = ["sg-045c84b3a0a181ac8"]
}
