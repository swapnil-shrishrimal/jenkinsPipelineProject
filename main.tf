resource "aws_instance" "deployment" {
    ami = "AMI_WHICH_YOU_WANT_TO_PROVISION"
    instance_type = "TYPE_OF_INSTANCE" // t2.micro, t2.small ..
    user_data = <<EOF  
#!/bin/bash
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io -y
sudo usermod -aG docker ec2-user
sudo systemctl start docker
docker run -d -p 80:80 swapnil19/angularapp
EOF
    tags = {
        Name = "Deployment Server"
    }
    vpc_security_group_ids = ["SECURITY_GROUP_TO_BE_GIVEN"]
}
