FROM openjdk:17-jdk-slim

WORKDIR /app

COPY backend/target/user-service-1.0.0.jar app.jar

EXPOSE 8002

ENTRYPOINT ["java", "-jar", "app.jar"]
