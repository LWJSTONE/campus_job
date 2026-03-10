FROM openjdk:17-jdk-slim

WORKDIR /app

COPY backend/target/message-service-1.0.0.jar app.jar

EXPOSE 8005

ENTRYPOINT ["java", "-jar", "app.jar"]
