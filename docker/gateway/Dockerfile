FROM openjdk:17-jdk-slim

WORKDIR /app

COPY backend/target/gateway-1.0.0.jar app.jar

EXPOSE 10000

ENTRYPOINT ["java", "-jar", "app.jar"]
