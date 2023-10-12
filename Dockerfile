FROM maven:3.9.4-eclipse-temurin-17-alpine as build

WORKDIR /app
COPY . /app
RUN mvn clean package

FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

COPY --from=build /app/target/my-app-1.0-SNAPSHOT.jar /app/hello-world.jar

ENTRYPOINT ["java", "-jar", "/app/hello-world.jar"]
 