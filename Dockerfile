FROM java:8
WORKDIR /
ADD java-tomcat-maven-example.war java-app.war
EXPOSE 8080
CMD java - jar java-app.war
