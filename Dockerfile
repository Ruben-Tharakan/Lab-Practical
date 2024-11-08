# Stage 1: Build the application using Maven
FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package

# Stage 2: Use OpenJDK to run the application
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/java-maven-app-1.0-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
