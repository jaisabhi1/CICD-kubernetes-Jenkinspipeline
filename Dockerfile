FROM java:8
WORKDIR /
COPY target/ target/
EXPOSE 8080
CMD java -jar target/dependency/webapp-runner.jar target/*.war
