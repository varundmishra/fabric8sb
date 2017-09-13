#!/bin/bash
export JAVA_HOME=/opt/java/jdk1.8.0_131
export PATH=$PATH:/opt/java/jdk1.8.0_131/bin
/opt/java/jdk1.8.0_131/bin/java -version
nohup /opt/java/jdk1.8.0_131/bin/java -jar -Dserver.port=80 /opt/weather-app-spring-1.0.0.BUILD-SNAPSHOT-nodb.jar >> /home/ec2-user/nohup.out 2>&1 &
sleep 20s
echo "Server Started"
echo "Printing Logs..."
sudo chmod 777 /home/ec2-user/nohup.out
cat /home/ec2-user/nohup.out
echo "Logs Printed!!!"