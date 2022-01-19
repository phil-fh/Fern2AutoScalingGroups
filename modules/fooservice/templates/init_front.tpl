#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install docker -y
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo docker run -p 8080:3000 -e IPLEFT=${left_host} -e IPRIGHT=${right_host} -d ${container_image}:${container_version}