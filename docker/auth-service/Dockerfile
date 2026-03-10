FROM openjdk:17-jdk-slim

WORKDIR /app

COPY backend/target/auth-service-1.0.0.jar app.jar

EXPOSE 8001

ENTRYPOINT ["java", "-jar", "app.jar"]
