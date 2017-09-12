#!/bin/bash
sudo mkdir -p /opt/java/
sudo chmod 777 /opt/java/
if [ -f /opt/java/jdk-8u131-linux-x64.tar.gz ]; then
        echo "The Java tar already exists"
else
cd /opt/java/ && sudo wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz
sleep 20s
    cd /opt/java/ && sudo tar xzf jdk-8u131-linux-x64.tar.gz
sleep 10s
echo "Setting Java Variables"
        sudo chmod 777 /etc/profile
	sudo echo "export JAVA_HOME=/opt/java/jdk1.8.0_131" >> /etc/profile
	sudo echo "export PATH=$PATH:/opt/java/jdk1.8.0_131/bin" >> /etc/profile
sudo chmod 755 /etc/profile
	echo "Java Variables have been set."
fi
