#!/bin/bash
sudo yum update -y
sudo yum install -y docker
sudo service docker start
sleep 10s
echo "\n Starting Docker Build..... "
cd /tmp/ && sudo docker build -t springboot -f Dockerfile.springboot .
sudo docker run -p 80:80 -p 9000:9000 -itd springboot
sudo docker exec `sudo docker ps | awk {'print $1'} | tail -1` sh /tmp/start.sh