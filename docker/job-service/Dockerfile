FROM openjdk:17-jdk-slim

WORKDIR /app

COPY backend/target/job-service-1.0.0.jar app.jar

EXPOSE 8003

ENTRYPOINT ["java", "-jar", "app.jar"]
