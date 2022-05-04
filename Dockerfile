FROM amazoncorretto:11

RUN mkdir /opt/app
ADD target/spring-petclinic-*.jar /opt/app/petclinic.jar
EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/opt/app/petclinic.jar"]