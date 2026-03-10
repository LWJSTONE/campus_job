FROM openjdk:17-jdk-slim

WORKDIR /app

COPY backend/target/application-service-1.0.0.jar app.jar

EXPOSE 8004

ENTRYPOINT ["java", "-jar", "app.jar"]
