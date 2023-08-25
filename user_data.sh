#!/bin/bash
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io -y
sudo usermod -aG docker ec2-user
sudo systemctl start docker
docker run -d -p 80:80 swapnil19/angular-app
