spring_boot_jar=weather-app-spring-1.0.0.BUILD-SNAPSHOT-nodb.jar
chmod +r /tmp/weather-app-spring-1.0.0.BUILD-SNAPSHOT-nodb.jar
sudo cp /tmp/weather-app-spring-1.0.0.BUILD-SNAPSHOT-nodb.jar /opt/weather-app-spring-1.0.0.BUILD-SNAPSHOT-nodb.jar
sudo chmod +x /opt/weather-app-spring-1.0.0.BUILD-SNAPSHOT-nodb.jar
#sudo sed -i -e  's/abcde/'$spring_boot_jar'/' /tmp/start_spring_boot.sh
sudo chmod +x /tmp/start_spring_boot.sh
sudo /tmp/start_spring_boot.sh