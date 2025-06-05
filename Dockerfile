FROM maven:3.9.9-eclipse-temurin AS buider
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -Dskiptests

FROM openjdk-21 AS runner 
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT [ "java" , "-jar" , "app.jar"]
