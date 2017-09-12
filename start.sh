spring_boot_jar=weather-app-spring-1.0.0.BUILD-SNAPSHOT-nodb.jar
chmod +r /tmp/$spring_boot_jar
sudo cp /tmp/$spring_boot_jar /opt/$spring_boot_jar
sudo chmod +x /opt/$spring_boot_jar
sudo sed -i -e  's/abcde/'$spring_boot_jar'/' /tmp/start_spring_boot.sh
sudo chmod +x /tmp/start_spring_boot.sh
sudo /tmp/start_spring_boot.sh