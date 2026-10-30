FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY app.jar app.jar
CMD ["java", "-cp", "app.jar", "GameMidlet.class"]
